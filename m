Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262782;
	b=NQml9WkE0O0KHFciJlzmHZEO0ZB+iP9XtmauWcqBs4LZ/dHx8L5+B7yL8vxENdo2oYiy
	 oUOISrrM6nEbF+PvA9J9DhHQkhxnhzQPhw5U06TbdokkZAEQ7JI3wJagYYErkdXJ1Upvb
	 3Mc2nOpUe6X2qZO5EK5gClhD+8IH/pBnR6ua81oZG1VIQqRRhUyIlX2D/B01LuFkaWx7v
	 vjXuAOVUQRhpjGWJJD0yfn9Hfn10AaEe7mLlzpDRbsg0dDyWFWSJ1LYBK0/uB8ueCJ2KD
	 aeAfG6UhzD6tbQm0DI2+HbYcYu0mBedscFh252WLnavHWxbK1evmQP+psdRx8vJwE7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262782;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XoLvTeJAGtGDIuEDeT+BdVGLsUywpuVDTzPK2UU+x74=;
	b=DVVjsdzprf9oMEQqgMVzUebR8hIRxxKt2qEh22cfanXLtqah88fnN5GHCSfBpn/YjX79
	 wfHCKs5Ud4Tn8D4R/vkKPHnOUOCWXHMBRScgf99ct3XfBPlie70yY8zjElf2zFHHtYiNc
	 hhMI+FbgfOvv0Rqiz1E2aUfc/UUcAhsL8xuJpFI92AkFTX/iHtj58zWArUDG0IsSu9vvB
	 ZjHVaZfDOWfDXrtQA4cQ2A6Ay8fXZs90CcaSrKF5LWTyMF/GVnKPcIRj5wpn0Qmdtssss
	 gVslnTNTbiw3/QCsjTPo/8vTU93pcfM9VTdB1sQy9CgbJJ6KV/8f1Bhm9SaMoj09fvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJup4OU1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE80160A2602;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XJup4OU1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 482DA1F00903;
	Mon,  9 Nov 2026 22:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794262781;
	bh=XoLvTeJAGtGDIuEDeT+BdVGLsUywpuVDTzPK2UU+x74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XJup4OU19gui/VUQrn9ejbS5Z+kztQSmz/OoYtIsESvgPZwfTb+rxbjJvnRHYdg9B
	 5xARgej3fDKYK7NHcnoAKJOWo1loWUIGq0xqWbEMaq0vRTm3+CsooBNLCOgFDrZwKv
	 pqEiRLEpeS15uqJY0tmCjLUU0pH/JQMMM6rm7yhNB6P3Ebn92KJWMteaXsj9C9hThD
	 6Wtuv8UGvZhrtE4ugnXlkGcnv5txh1HHgcUf6xDBkC55TfLzL08GJF6tLZ+AUGLkXD
	 cqU+294PJSRAVuoQWInp0YxEYehiZXI3tzY4fAXYJ1+V8Xnv3hCDV5R1G3a/+NPOfC
	 eFW8rU9V9VMyg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BF152CE1328; Mon,  9 Nov 2026 14:19:40 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 8/8] doc: Document additional RCU task-stall dump information
Date: Mon,  9 Nov 2026 14:19:39 -0800
Message-Id: <20261109221939.2070171-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
References: <db8c185c-5523-48e5-abee-020503b4875f@paulmck-laptop>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This commit adds explanation for the added task-stall dumps, which can
be as follows:

	Tasks blocked on level-1 rcu_node (CPUs 0-8): P96/1:b..l.B CPU 5 swapper/5 (0) (idle!)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 71 +++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index a986358a5c279..b888e13c02a49 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -234,6 +234,7 @@ CPU is stalling, it will print a message similar to the following::
 	INFO: rcu_sched detected stalls on CPUs/tasks:
 	2-...: (3 GPs behind) idle=06c/0/0 softirq=1453/1455 fqs=0
 	16-...: (0 ticks this GP) idle=81c/0/0 softirq=764/764 fqs=0
+	Tasks blocked on level-1 rcu_node (CPUs 0-8): P96/1:b..l.B CPU 5 swapper/5 (0) (idle!)
 	(detected by 32, t=2603 jiffies, g=7075, q=625)
 
 This message indicates that CPU 32 detected that CPUs 2 and 16 were both
@@ -278,6 +279,70 @@ detection passes that the grace-period kthread has made across this
 CPU since the last time that this CPU noted the beginning of a grace
 period.
 
+The "Tasks blocked" line lists the tasks blocked on each leaf ``rcu_node``
+structure.  The "(CPUs 0-8)" indicates that this particular leaf
+``rcu_node`` structure handles the nine CPUs numbered from 0 to 8,
+which indicates an odd but perfectly legal state of affairs ("0-15"
+is typical).  The "P96" indicates that the task with PID 96 is blocking
+the current grace period.
+
+Certain race conditions can prevent the remaining information on this
+line from appearing, most typically that task P96 is currently running on
+some other CPU.  The "/1" indicates that this task was preempted within
+its top-level RCU read-side critical section.  The ":b..l.B" indicates
+task state as follows, with "." indicating that the corresponding state
+is not in effect:
+
+b (blocked)
+   This task has been preempted (blocked) at least once during its
+   current RCU read-side critical section.
+
+q (needs quiescent state)
+   This task has been flagged as running on a CPU from which RCU needs
+   a quiescent state.
+
+e (expedited hint)
+   An expedited RCU grace period is interested in this task.
+
+l (on ->blkd_tasks list)
+   This task is currently on a list of blocked (preempted) tasks that
+   either are or might some day hold up an RCU grace period.  Note that
+   if the task has not yet been preempted, this task will not be on any
+   of these lists, which means that RCU will still be waiting on the
+   CPU the task is running on, not yet the task itself.
+
+R (Running)
+   This task is running (as opposed to just runnable, that is, preempted).
+   This is unusual, but could happen if the task was preempted and
+   started running again before this RCU CPU stall warning.
+
+B (Boosted)
+   This task is currently priority boosted.  There is a narrow window
+   during which the rtmutex has been created with this task as owner,
+   but the rcub task has not yet attempted to acquire that rtmutex.
+   During this narrow window, the task would be reported as being boosted,
+   but would not yet actually be boosted.
+
+The "CPU 5" indicates that the task is in CPU 5’s runqueue and that
+this CPU is online.  If the CPU were offline, this would instead read
+"CPU 5!".  The "swapper/5" is the running task’s ->comm string.
+If there was somehow no task running on CPU 5, this would instead read
+"???".  The "(0)" indicates that the running task’s PID is zero.
+Which is a problem.  If there was somehow no task running on CPU 5,
+this would instead read "(-1)".
+
+The "(idle!)" indicates that the task currently running on CPU 5 is its
+idle task, which is not supposed to happen, other than during small
+windows of time where one CPU wakes up a task that is to run on an
+idle CPU.  (The rescheduling IPI does after all take time to reach the
+idle CPU!)  If there was somehow no task running on CPU 5, this would
+instead read "(no task)".  Otherwise, nothing would be printed.
+
+If there was more than one task queued on this ``rcu_node`` structure,
+for example, suppose that task P192 was also blocking the current RCU
+grace period.  In that case, the line would contine with P192 followed
+optionally by the rest of the per-task information.
+
 The "detected by" line indicates which CPU detected the stall (in this
 case, CPU 32), how many jiffies have elapsed since the start of the grace
 period (in this case 2603), the grace-period sequence number (7075), and
@@ -307,7 +372,7 @@ The "23807" indicates that it has been more than 23 thousand jiffies
 since the grace-period kthread ran.  The "jiffies_till_next_fqs"
 indicates how frequently that kthread should run, giving the number
 of jiffies between force-quiescent-state scans, in this case three,
-which is way less than 23807.  Finally, the root rcu_node structure's
+which is way less than 23807.  Finally, the root ``rcu_node`` structure's
 ->qsmask field is printed, which will normally be zero.
 
 If the relevant grace-period kthread has been unable to run prior to
@@ -382,10 +447,10 @@ jiffies.  The number following the "s:" indicates that the expedited
 grace-period sequence counter is 73.  The fact that this last value is
 odd indicates that an expedited grace period is in flight.  The number
 following "root:" is a bitmask that indicates which children of the root
-rcu_node structure correspond to CPUs and/or tasks that are blocking the
+``rcu_node`` structure correspond to CPUs and/or tasks that are blocking the
 current expedited grace period.  If the tree had more than one level,
 additional hex numbers would be printed for the states of the other
-rcu_node structures in the tree.
+``rcu_node`` structures in the tree.
 
 As with normal grace periods, PREEMPT_RCU builds can be stalled by
 tasks as well as by CPUs, and that the tasks will be indicated by PID,
-- 
2.40.1

