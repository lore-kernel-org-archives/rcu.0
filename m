Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531073;
	b=siHT9IBVqgK3UMg8qPSD4gDLV/JKRu7TL/QBh2FR5bdGQwXHxbguOJ/0BaOYmUyZ1W9T
	 MPya/yOtgS+Za++4hNhdtB8C5Ndn/DJhLjV0FRG2ti0NDbFleEoVCUNLW0miGwOIYvMdQ
	 vye7X/XKgyZc+hUCHDuipjJtpe6ieG1kWdU89ju37BiBktp+RZsnz1fv1OlVbiRXwOZX3
	 HK4k89Gi3phsEPr+3wYdbO/giImYHLz0/C9XtOnLT2jPm4xWs9Tj7y7BlleZBV0HdZ5i9
	 nYlMI2aEhcszc3eNVwLzdJ4sGIS/ipM+Y9TJVrgY8YaqK9LZPezcysyTGLQnczgL9fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531073;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OGO8U8NuhOL+5jnMQtJSjUGv14iL8UFqhPtTyBYrrjs=;
	b=s/IxuhyGMCSB9vTmMQdZbNR3R6/xCUW4/dWGq2/dcOQ4AWxFoF9BjjCfAWjko0MSLrcN
	 beaag3I7usfA2A5ea4YDQkccya2FT18dmNMzqQDMBDwDcB9NPXteDf34n8w2LM/R6J6CP
	 U5Ird3+g0YDDaMnvRm/2uCPyJmO2q69Bs4QDzTSa6kLWps3IWIBgj8zgvkKK8wfiv6PMd
	 1EqtdFV4uFcom5ZHngcohRDf8/85WIhHgjDBaN2NoLYeA78Vq8eOqUpi6Wx+MO1UhnUmi
	 WzmyzxBJxltlTANck7kWGlWvMMssL5TV8khWOEFOjxTGMi5TTmQAr7L9VRaFKg2NGPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRxlC855;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E22DE606AD16;
	Fri, 13 Nov 2026 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRxlC855
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D99F1F000C6;
	Fri, 13 Nov 2026 00:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531072;
	bh=OGO8U8NuhOL+5jnMQtJSjUGv14iL8UFqhPtTyBYrrjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mRxlC855Ex2qemPLQfhlKYUD8B0OGZq0qlagmrc2KKWYN5kMf5wHGu/parslDhb5W
	 PaEwTAMY69wEVCQTMnTYQdED+nEei60U+Fq7sa2d3PRhnMnFSPlPChPid+yl8c9EoD
	 /1ePoD73e9wgfPF2mhZotnmpuDfbmhLGDs4JaV8SIv8YkQLfNocR7eR2YdDd3K4M1z
	 PjeqCXmaA0G1d17bCjoEk+DjNhFeMLlLtyJd0H7I8eV3fnLDoihVx2hLhF3ggURoO0
	 FyGNNWPxuNbMtXCbIrsGC1TCLHwb5hCf0erE75jVAxgAqkDpp3d7apYRrbg6lm/bGR
	 c9Eq1CvQt2GxA==
From: Joel Fernandes <jfern@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <jfern@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: rcu@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH for-v7.5 5/5] doc: Document additional RCU task-stall dump information
Date: Thu, 12 Nov 2026 19:50:54 -0500
Message-ID: <20261113005056.2793983-6-jfern@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261113005056.2793983-1-jfern@kernel.org>
References: <20261113005056.2793983-1-jfern@kernel.org>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds explanation for the added task-stall dumps, which can
be as follows:

	Tasks blocked on level-1 rcu_node (CPUs 0-8): P96/1:b..l.B CPU 5 swapper/5 (0) (idle!)

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Joel Fernandes <jfern@kernel.org>
---
 Documentation/RCU/stallwarn.rst | 71 +++++++++++++++++++++++++++++++--
 1 file changed, 68 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 118c47506753..049694b9c681 100644
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
2.54.0

