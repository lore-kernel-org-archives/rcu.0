Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC98399;
	Thu, 13 Jun 2024 13:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718283711; cv=none; b=Yt/rguGNs03AWa8Kax7p2zW+0/4a4LPtQAjywATfjtJbluP4/axrZv08vx/goX/ukzh/OSH42hePNCvO2DpEgDgHZ7KOcR82nwsAwYwhUDU2sKDEJfHfaaC6QYkqYCe7x3kVGzQcH+p32Y2RBVohMkq0zkesmXgaMFMEYVtlrEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718283711; c=relaxed/simple;
	bh=sv0CgoDIv0Vula3DjwS5QjyizO10caELR+SL/nnES0Y=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=V4lqCt79uZO0VCfl2kcBdUQ7tnewO5sIiMa+WTJgVYqABMejBDt1Z0AQQ8lfWtUEukHX/phNTTmWWdgvkIjIdAwSYPUIS2mOfJ8hgUvz771cdClgi0LIjC3d8gsVxOTfjzKX2TDcPpWbxQdLcqUFZrQONApfB2lDQwzI5s/Qnqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:60898)
	by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHk5F-0041SY-8b; Thu, 13 Jun 2024 07:01:41 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:43834 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHk5D-003h7s-T0; Thu, 13 Jun 2024 07:01:40 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Rachel Menge
 <rachelmenge@linux.microsoft.com>,  linux-kernel@vger.kernel.org,
  rcu@vger.kernel.org,  Wei Fu <fuweid89@gmail.com>,
  apais@linux.microsoft.com,  Sudhanva Huruli
 <Sudhanva.Huruli@microsoft.com>,  Jens Axboe <axboe@kernel.dk>,  Christian
 Brauner <brauner@kernel.org>,  Mike Christie
 <michael.christie@oracle.com>,  Joel Granados <j.granados@samsung.com>,
  Mateusz Guzik <mjguzik@gmail.com>,  "Paul E. McKenney"
 <paulmck@kernel.org>,  Frederic Weisbecker <frederic@kernel.org>,  Neeraj
 Upadhyay <neeraj.upadhyay@kernel.org>,  Joel Fernandes
 <joel@joelfernandes.org>,  Josh Triplett <josh@joshtriplett.org>,  Boqun
 Feng <boqun.feng@gmail.com>,  Steven Rostedt <rostedt@goodmis.org>,
  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,  Lai Jiangshan
 <jiangshanlai@gmail.com>,  Zqiang <qiang.zhang1211@gmail.com>
References: <1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com>
	<20240608154835.GD7947@redhat.com>
Date: Thu, 13 Jun 2024 08:01:24 -0500
In-Reply-To: <20240608154835.GD7947@redhat.com> (Oleg Nesterov's message of
	"Sat, 8 Jun 2024 17:48:35 +0200")
Message-ID: <87msnpov2z.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sHk5D-003h7s-T0;;;mid=<87msnpov2z.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+AyFdOXUD7FQaysfYdpF4/jg8gzGnb1oY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 500 ms - load_scoreonly_sql: 0.12 (0.0%),
	signal_user_changed: 11 (2.2%), b_tie_ro: 9 (1.9%), parse: 1.03 (0.2%),
	 extract_message_metadata: 5 (1.0%), get_uri_detail_list: 2.2 (0.4%),
	tests_pri_-2000: 3.8 (0.8%), tests_pri_-1000: 4.7 (0.9%),
	tests_pri_-950: 1.92 (0.4%), tests_pri_-900: 1.29 (0.3%),
	tests_pri_-90: 92 (18.3%), check_bayes: 89 (17.9%), b_tokenize: 10
	(2.0%), b_tok_get_all: 9 (1.8%), b_comp_prob: 2.8 (0.6%),
	b_tok_touch_all: 63 (12.5%), b_finish: 1.18 (0.2%), tests_pri_0: 345
	(68.9%), check_dkim_signature: 1.02 (0.2%), check_dkim_adsp: 3.6
	(0.7%), poll_dns_idle: 0.72 (0.1%), tests_pri_10: 4.2 (0.8%),
	tests_pri_500: 19 (3.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] zap_pid_ns_processes: don't send SIGKILL to sub-threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> The comment above the idr_for_each_entry_continue() loop tries to explain
> why we have to signal each thread in the namespace, but it is outdated.
> This code no longer uses kill_proc_info(), we have a target task so we can
> check thread_group_leader() and avoid the unnecessary group_send_sig_info.
> Better yet, we can change pid_task() to use PIDTYPE_TGID rather than _PID,
> this way it returns NULL if this pid is not a group-leader pid.
>
> Also, change this code to check SIGNAL_GROUP_EXIT, the exiting process /
> thread doesn't necessarily has a pending SIGKILL. Either way these checks
> are racy without siglock, so the patch uses data_race() to shut up KCSAN.

You remove the comment but the meat of what it was trying to say remains
true.  For processes in a session or processes is a process group a list
of all such processes is kept.  No such list is kept for a pid
namespace.  So the best we can do is walk through the allocated pid
numbers in the pid namespace.

It would also help if this explains that in the case of SIGKILL
complete_signal always sets SIGNAL_GROUP_EXIT which makes that a good
check to use to see if the process has been killed (with SIGKILL).
There are races with coredump here but *shrug* I don't think this
changes behavior in that situation.

Eric


> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/pid_namespace.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index 25f3cf679b35..0f9bd67c9e75 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -191,21 +191,14 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	 * The last thread in the cgroup-init thread group is terminating.
>  	 * Find remaining pid_ts in the namespace, signal and wait for them
>  	 * to exit.
> -	 *
> -	 * Note:  This signals each threads in the namespace - even those that
> -	 * 	  belong to the same thread group, To avoid this, we would have
> -	 * 	  to walk the entire tasklist looking a processes in this
> -	 * 	  namespace, but that could be unnecessarily expensive if the
> -	 * 	  pid namespace has just a few processes. Or we need to
> -	 * 	  maintain a tasklist for each pid namespace.
> -	 *
>  	 */
>  	rcu_read_lock();
>  	read_lock(&tasklist_lock);
>  	nr = 2;
>  	idr_for_each_entry_continue(&pid_ns->idr, pid, nr) {
> -		task = pid_task(pid, PIDTYPE_PID);
> -		if (task && !__fatal_signal_pending(task))
> +		task = pid_task(pid, PIDTYPE_TGID);
> +		/* reading signal->flags is racy without sighand->siglock */
> +		if (task && !(data_race(task->signal->flags) & SIGNAL_GROUP_EXIT))
>  			group_send_sig_info(SIGKILL, SEND_SIG_PRIV, task, PIDTYPE_MAX);
>  	}
>  	read_unlock(&tasklist_lock);
