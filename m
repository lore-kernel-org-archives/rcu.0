Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D747B143C7E;
	Thu, 13 Jun 2024 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295849; cv=none; b=IJ7KgEunOeJEfiX3m/lninea+Q6Wnfbq5HeFk6/TbP6ctAQ6nyBzFN/fNBIK8arIJyplWEvf/hemkabvKxuwyWVTfsgZCWCuaHJeXgglgin9ZsTdpcQYnYyDQz0+NlY+w+Ar941yNxOBsP68TNBAQke04JizTf+D9EqaTXw7jng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295849; c=relaxed/simple;
	bh=8qBRS327eIP/TqtaE/AT4eVCXfgL+WcJlCmAdNxuu7A=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=FAznqKf8QJRVA1h5mX1OFouYakGCnVzheUhqyh2nUoyEpZN1UOpiEiIazYGk4p4vUP1cxfyWaTuHAAcXbPXmzc/dXpCxlwEse55PRT2Iik7JUN4BrH82SDdIl5ge7oGj25P7wBvJQOg/jKWWmtgWXq580CR5C4rgEgRpnQiNqLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:42542)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHnF7-00Dix6-9E; Thu, 13 Jun 2024 10:24:05 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:57668 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHnF6-004J5z-5B; Thu, 13 Jun 2024 10:24:04 -0600
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
	<87msnpov2z.fsf@email.froward.int.ebiederm.org>
	<20240613150001.GB18218@redhat.com>
Date: Thu, 13 Jun 2024 11:23:37 -0500
In-Reply-To: <20240613150001.GB18218@redhat.com> (Oleg Nesterov's message of
	"Thu, 13 Jun 2024 17:00:02 +0200")
Message-ID: <874j9wolpy.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sHnF6-004J5z-5B;;;mid=<874j9wolpy.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18HHPil1Fu2eslCsbOWbqIK4ZS+5Nib4Jk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4948]
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
	*  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 478 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 11 (2.2%), b_tie_ro: 9 (1.9%), parse: 1.10 (0.2%),
	 extract_message_metadata: 4.0 (0.8%), get_uri_detail_list: 1.62
	(0.3%), tests_pri_-2000: 3.4 (0.7%), tests_pri_-1000: 6 (1.3%),
	tests_pri_-950: 2.4 (0.5%), tests_pri_-900: 1.85 (0.4%),
	tests_pri_-90: 93 (19.4%), check_bayes: 91 (19.0%), b_tokenize: 9
	(2.0%), b_tok_get_all: 8 (1.8%), b_comp_prob: 2.9 (0.6%),
	b_tok_touch_all: 66 (13.8%), b_finish: 0.94 (0.2%), tests_pri_0: 330
	(68.9%), check_dkim_signature: 0.75 (0.2%), check_dkim_adsp: 3.2
	(0.7%), poll_dns_idle: 0.63 (0.1%), tests_pri_10: 2.4 (0.5%),
	tests_pri_500: 16 (3.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] zap_pid_ns_processes: don't send SIGKILL to sub-threads
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> On 06/13, Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@redhat.com> writes:
>>
>> > The comment above the idr_for_each_entry_continue() loop tries to explain
>> > why we have to signal each thread in the namespace, but it is outdated.
>> > This code no longer uses kill_proc_info(), we have a target task so we can
>> > check thread_group_leader() and avoid the unnecessary group_send_sig_info.
>> > Better yet, we can change pid_task() to use PIDTYPE_TGID rather than _PID,
>> > this way it returns NULL if this pid is not a group-leader pid.
>> >
>> > Also, change this code to check SIGNAL_GROUP_EXIT, the exiting process /
>> > thread doesn't necessarily has a pending SIGKILL. Either way these checks
>> > are racy without siglock, so the patch uses data_race() to shut up KCSAN.
>>
>> You remove the comment but the meat of what it was trying to say remains
>> true.  For processes in a session or processes is a process group a list
>> of all such processes is kept.  No such list is kept for a pid
>> namespace.  So the best we can do is walk through the allocated pid
>> numbers in the pid namespace.
>
> OK, I'll recheck tomorrow. Yet I think it doesn't make sense to send
> SIGKILL to sub-threads, and the comment looks misleading today. This was
> the main motivation, but again, I'll recheck.

Yes, we only need to send SIGKILL to only one thread.
Of course there are a few weird cases with zombie leader threads,
but I think the pattern you are using handles them.

>> It would also help if this explains that in the case of SIGKILL
>> complete_signal always sets SIGNAL_GROUP_EXIT which makes that a good
>> check to use to see if the process has been killed (with SIGKILL).
>
> Well, if SIGNAL_GROUP_EXIT is set we do not care if this process was
> killed or not. It (the whole thread group) is going to exit, that is all.
>
> We can even remove this check, it is just the optimization, just like
> the current fatal_signal_pending() check.

I just meant that the optimization is effective because
group_send_sig_info calls complete_signal which sets SIGNAL_GROUP_EXIT.

Which makes it an almost 100% accurate test, which makes it a very
good optimization.  Especially in the case of multi-threaded processes
where the code will arrive there for every thread.

Eric

