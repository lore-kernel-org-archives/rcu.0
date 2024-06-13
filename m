Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79244142E86;
	Thu, 13 Jun 2024 12:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718282474; cv=none; b=p4NeXDRiMReNUy2LdhEqI4ad884axB0Y+8qSAfBR+MGaOOeDExWDvgxbdPaAeGOqCCPKeNuutNqy6FY8BB0Zg0kwWA9OQ97N2XqOMCdWr+CEr1urnBO08AtiGna6FpMcLR3nXjiXtqUHDq301UcccFS1yo0ZHiAOvZYg/954nvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718282474; c=relaxed/simple;
	bh=dD6ShW76KbkH42bBEwPS/NzvqunFMNOkDf05maEapns=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=eKm54VnWexO94MaXEgrA4IikZs6reFx7HwJyIg1asDbbw2YJPxhEM075y6y46gGGk6gsr8tgUK+qg1KXQVLEbFBr7yoNZs4titM3yYJb1+2oK19Ycx2Rv3MEPorYvbhqSOXj3DZwi7dhmcGBeIVQS5ngtykbWh2Mo9/P4dussA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in02.mta.xmission.com ([166.70.13.52]:35548)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHjlH-00DJUt-DE; Thu, 13 Jun 2024 06:41:03 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41526 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sHjlE-003eVV-7O; Thu, 13 Jun 2024 06:41:03 -0600
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
	<20240608120616.GB7947@redhat.com>
Date: Thu, 13 Jun 2024 07:40:06 -0500
In-Reply-To: <20240608120616.GB7947@redhat.com> (Oleg Nesterov's message of
	"Sat, 8 Jun 2024 14:06:16 +0200")
Message-ID: <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sHjlE-003eVV-7O;;;mid=<87a5jpqamx.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18qLrVAX1hXXj2C18cuMCIcy/jiniNxzDk=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Virus: No
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.4998]
	*  0.7 XMSubLong Long Subject
	*  0.5 XMGappySubj_01 Very gappy subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Oleg Nesterov <oleg@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 358 ms - load_scoreonly_sql: 0.03 (0.0%),
	signal_user_changed: 3.8 (1.1%), b_tie_ro: 2.6 (0.7%), parse: 0.69
	(0.2%), extract_message_metadata: 2.9 (0.8%), get_uri_detail_list:
	1.43 (0.4%), tests_pri_-2000: 2.8 (0.8%), tests_pri_-1000: 2.7 (0.7%),
	tests_pri_-950: 1.04 (0.3%), tests_pri_-900: 0.80 (0.2%),
	tests_pri_-90: 71 (19.9%), check_bayes: 70 (19.6%), b_tokenize: 7
	(1.9%), b_tok_get_all: 8 (2.3%), b_comp_prob: 1.88 (0.5%),
	b_tok_touch_all: 51 (14.2%), b_finish: 0.61 (0.2%), tests_pri_0: 259
	(72.2%), check_dkim_signature: 0.39 (0.1%), check_dkim_adsp: 2.2
	(0.6%), poll_dns_idle: 0.93 (0.3%), tests_pri_10: 1.73 (0.5%),
	tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along
 with TIF_SIGPENDING
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Oleg Nesterov <oleg@redhat.com> writes:

> kernel_wait4() doesn't sleep and returns -EINTR if there is no
> eligible child and signal_pending() is true.
>
> That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> return false and avoid a busy-wait loop.

I took a look through the code.  It used to be that TIF_NOTIFY_SIGNAL
was all about waking up a task so that task_work_run can be used.
io_uring still mostly uses it that way.  There is also a use in
kthread_stop that just uses it as a TIF_SIGPENDING without having a
pending signal.

At the point in do_exit where exit_notify and thus zap_pid_ns_processes
is called I can't possibly see a use for TIF_NOTIFY_SIGNAL.
exit_task_work, exit_signals, and io_uring_cancel have all been called.

So TIF_NOTIFY_SIGNAL should be spurious at this point and safe to clear.
Why it remains set is a mystery to me.


If I had infinite time and energy the ideal is to rework the pid
namespace exit logic so that waiting for everything to exit works like
delay_group_leader in wait_task_consider.  Simply blocking reaping of
the pid namespace leader until everything in the pid namespace have been
reaped.  I think acct_exit_ns is the only piece of code that needs
to be moved to allow that, and acct_exit_ns is purely bookkeeping so
does not affect userspace visible semantics.

This active waiting is weird and non-standard in the kernel and winds up
causeing a problem every couple of years because of that.

>
> Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
> Reported-by: Rachel Menge <rachelmenge@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/pid_namespace.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index dc48fecfa1dc..25f3cf679b35 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -218,6 +218,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
>  	 */
>  	do {
>  		clear_thread_flag(TIF_SIGPENDING);
> +		clear_thread_flag(TIF_NOTIFY_SIGNAL);
>  		rc = kernel_wait4(-1, NULL, __WALL, NULL);
>  	} while (rc != -ECHILD);
