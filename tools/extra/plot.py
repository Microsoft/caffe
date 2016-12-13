# In the name of GOD the most compassionate the most merciful
# Originally developed by Yasse Souri
# Just added the search for current directory so that users dont have to use command prompts anymore!
# and also shows the top 4 accuracies achieved so far, and displaying the highest in the plot title 
# Coded By: Seyyed Hossein Hasan Pour (Coderx7@gmail.com)
# -------How to Use ---------------
# 1.Just place your caffe's traning/test log file (with .log extension) next to this script
# and then run the script.If you have multiple logs placed next to the script, it will plot all of them
# you may also copy this script to your working directory, where you generate/keep your train/test logs
# and easily execute the script and see the curve plotted. 
# this script is standalone.
# 2. you can use command line arguments as well, just feed the script with different log files separated by space
# and you are good to go.
#----------------------------------
import numpy as np
import re
import click
import glob, os
from matplotlib import pylab as plt
import operator
import ntpath
@click.command()
@click.argument('files', nargs=-1, type=click.Path(exists=True))
def main(files):
    plt.style.use('ggplot')
    fig, ax1 = plt.subplots()
    ax2 = ax1.twinx()
    ax1.set_xlabel('iteration')
    ax1.set_ylabel('loss')
    ax2.set_ylabel('accuracy %')
    if not files:
        print 'no args found'
        print '\n\rloading all files with .log extension from current directory'
        os.chdir(".")
        files = glob.glob("*.log")

    for i, log_file in enumerate(files):
        loss_iterations, losses, accuracy_iterations, accuracies, accuracies_iteration_checkpoints_ind, fileName = parse_log(log_file)
        disp_results(fig, ax1, ax2, loss_iterations, losses, accuracy_iterations, accuracies, accuracies_iteration_checkpoints_ind, fileName, color_ind=i)
    plt.show()


def parse_log(log_file):
    with open(log_file, 'r') as log_file2:
        log = log_file2.read()

    loss_pattern = r"Iteration (?P<iter_num>\d+), loss = (?P<loss_val>[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?)"
    losses = []
    loss_iterations = []

    fileName= os.path.basename(log_file)
    for r in re.findall(loss_pattern, log):
        loss_iterations.append(int(r[0]))
        losses.append(float(r[1]))

    loss_iterations = np.array(loss_iterations)
    losses = np.array(losses)

    accuracy_pattern = r"Iteration (?P<iter_num>\d+), Testing net \(#0\)\n.* accuracy = (?P<accuracy>[+-]?(\d+(\.\d*)?|\.\d+)([eE][+-]?\d+)?)"
    accuracies = []
    accuracy_iterations = []
    accuracies_iteration_checkpoints_ind = []

    for r in re.findall(accuracy_pattern, log):
        iteration = int(r[0])
        accuracy = float(r[1]) * 100

        if iteration % 10000 == 0 and iteration > 0:
            accuracies_iteration_checkpoints_ind.append(len(accuracy_iterations))

        accuracy_iterations.append(iteration)
        accuracies.append(accuracy)

    accuracy_iterations = np.array(accuracy_iterations)
    accuracies = np.array(accuracies)
	
    return loss_iterations, losses, accuracy_iterations, accuracies, accuracies_iteration_checkpoints_ind, fileName


def disp_results(fig, ax1, ax2, loss_iterations, losses, accuracy_iterations, accuracies, accuracies_iteration_checkpoints_ind, fileName, color_ind=0):
    modula = len(plt.rcParams['axes.color_cycle'])
    acrIterations =[]
    top_acrs={}
    if accuracies.size:
        if 	accuracies.size>4:
		    top_n = 4
        else:
            top_n = accuracies.size -1		
        temp = np.argpartition(-accuracies, top_n)
        result_indexces = temp[:top_n]
        temp = np.partition(-accuracies, top_n)
        result = -temp[:top_n]
        for acr in result_indexces:
            acrIterations.append(accuracy_iterations[acr])
            top_acrs[str(accuracy_iterations[acr])]=str(accuracies[acr])

        sorted_top4 = sorted(top_acrs.items(), key=operator.itemgetter(1))
        maxAcc = np.amax(accuracies, axis=0)
        iterIndx = np.argmax(accuracies)
        maxAccIter = accuracy_iterations[iterIndx]
        maxIter =   accuracy_iterations[-1]
        consoleInfo = format('\n[%s]:maximum accuracy [from 0 to %s ] = [Iteration %s]: %s ' %(fileName,maxIter,maxAccIter ,maxAcc))
        plotTitle = format('max accuracy(%s) [Iteration %s]: %s ' % (fileName,maxAccIter, maxAcc))
        print (consoleInfo)
        #print (str(result))
        #print(acrIterations)
       # print 'Top 4 accuracies:'		
        print ('Top 4 accuracies:'+str(sorted_top4))		
        plt.title(plotTitle)
    ax1.plot(loss_iterations, losses, color=plt.rcParams['axes.color_cycle'][(color_ind * 2 + 0) % modula])
    ax2.plot(accuracy_iterations, accuracies, plt.rcParams['axes.color_cycle'][(color_ind * 2 + 1) % modula], label=str(fileName))
    ax2.plot(accuracy_iterations[accuracies_iteration_checkpoints_ind], accuracies[accuracies_iteration_checkpoints_ind], 'o', color=plt.rcParams['axes.color_cycle'][(color_ind * 2 + 1) % modula])
    plt.legend(loc='lower right') 


if __name__ == '__main__':
    main()