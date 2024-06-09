Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D31CA96;
	Sun,  9 Jun 2024 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717942389; cv=none; b=SFSgr7HzmQCnoTCRpsHEXY5AEUKAbZyeYScUD+cFRTPspNOmt220nbjx03vf3KOnxqAUENMnrzOZi+Xvpsh8SCx5OqaPOF1/ORPsLX8/6lD0jjIpJ/nQtsPOLcXFlUwL8iOMC96yrJG6Igk7LQNd3uDe9x5y8BBcw80Gf2yVwl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717942389; c=relaxed/simple;
	bh=RPUqh0YRQMY/bnzJlVrToKYU2tLxFFKggTCer8KeMJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJwEwzlwk5n6KlTztAK2HH0HKzG/3d9DdhTYGIE9JkWyOPVv3wd1hP8Ar/ZIvIEHhr5ezUUBOsILsUHz4vIZ1J7qS4zKx+QgDawjknoX4hSSiSc9De1T/urwjRwWSVobi+8uyKp0ZaGYr9G0knDolG8V9IKdBVZLD3whOIjrg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEnGUrLr; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEnGUrLr"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f44b441b08so27745235ad.0;
        Sun, 09 Jun 2024 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717942387; x=1718547187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jVP9gZF1z69z90rblB0DvNlsS4xXMrofV6Qh1n5Tx4c=;
        b=YEnGUrLr1ZKBfQK0QB/fCwOWVMFmerWL++Y9USDOC6khMnKjvBx91aLO3c4l0KoAyo
         MZCDtPn4j1kqfVpQdVzC9+7UWBO1ptHUXeAtnxW/H2P2pP2XrQ9282zPQuX5x71YVKHp
         9guwwZcyE2md7dpQlD9/tCSg8s1DqUbZhNPdENAwDRxkkqkjLULwp2TiAEYgRp6hwvrY
         1j6ALoIcdGt+U9kVEZwYbK+ais75GB4+Zr95gS55aaTPrbnun2je4Z1Ul/gYX36GzNfE
         ob9HbezMTVx7rqklxlApELitCBT1bSTq5w3I0Kv25lkV7rm+0ArPyXVZDnBROOi2DXCU
         22zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717942387; x=1718547187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jVP9gZF1z69z90rblB0DvNlsS4xXMrofV6Qh1n5Tx4c=;
        b=UYpT1+2cArcUQf7Q6a3yvSfvYyiQiXHtZl6kNSZkLuZqouJHwWmF+K9Hi+BIKFldrO
         h6dNwgm5f5WS8jJiw+mW4iwp+0lSlJJK3WyhjgqcMqm0ie5Awp/EOsMWDr2BZVAY2C2h
         10LVhB5i+6U/RlLGMcMXTgCLHO//4egEJUaBJr4MoY9pZkvYlDMlVRMHdV/kJAxQI8/u
         XBhr2GPVAKSKpxS/yzzJpl5LbMtF/M1T5wAdUPrA63Yr7CZ2SBtyG99UDHgvzpbnm0ZR
         Fg04il9kAasYBbV6bYcdFsxZKjj0oahP8GxSCuJ/x9v88AHRnYZTptuh+e+9jhtP3G9R
         jbLg==
X-Forwarded-Encrypted: i=1; AJvYcCXwaoGFov8RHZMdAr0Hwc7OW/+HUil78WRpn3gncLgOkR2gks8mqCkwYDBrDqBYfrflnOuBhVr2WF2HwIrLcsRVnbvLejPlDWH+Hc3SGwXtbbHpT1Ma+dK7dcW9Fdb/CvzT
X-Gm-Message-State: AOJu0YzK/7zg/CGXEPRGZr0USAu4OejnXIocHVlWm+BvAmcwaypFtbvc
	cEIIb83TOwl7ObWd26P2LMfZyhCcIia1uRIYHLVPkGRsJcBg4jnD
X-Google-Smtp-Source: AGHT+IH0kVsdRsvkC9sjpweoKQAM/B+Fy+4c9BoCfcCuMFsOmJSt4FoTvvvkuxs1DdqTcj7rnqazQw==
X-Received: by 2002:a17:902:d2d2:b0:1f7:2ba:4c15 with SMTP id d9443c01a7336-1f702ba4de5mr26736215ad.2.1717942387125;
        Sun, 09 Jun 2024 07:13:07 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6dcb222aesm43572455ad.49.2024.06.09.07.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 07:13:06 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: oleg@redhat.com
Cc: Sudhanva.Huruli@microsoft.com,
	akpm@linux-foundation.org,
	apais@linux.microsoft.com,
	axboe@kernel.dk,
	boqun.feng@gmail.com,
	brauner@kernel.org,
	frederic@kernel.org,
	fuweid89@gmail.com,
	j.granados@samsung.com,
	jiangshanlai@gmail.com,
	joel@joelfernandes.org,
	josh@joshtriplett.org,
	linux-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	michael.christie@oracle.com,
	mjguzik@gmail.com,
	neeraj.upadhyay@kernel.org,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org
Subject: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING
Date: Sun,  9 Jun 2024 22:12:44 +0800
Message-ID: <20240609141244.1770896-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240608120616.GB7947@redhat.com>
References: <20240608120616.GB7947@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> kernel_wait4() doesn't sleep and returns -EINTR if there is no
> eligible child and signal_pending() is true.
> 
> That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> return false and avoid a busy-wait loop.
> 
> Fixes: 12db8b690010 ("entry: Add support for TIF_NOTIFY_SIGNAL")
> Reported-by: Rachel Menge <rachelmenge@linux.microsoft.com>
> Closes: https://lore.kernel.org/all/1386cd49-36d0-4a5c-85e9-bc42056a5a38@linux.microsoft.com/
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Tested-By: Wei Fu <fuweid89@gmail.com>

This change looks good to me!

I used [rcudeadlock-v1][1] to verify this patch on v5.15.160 for more than 30
hours. The soft lockup didn't show up. If there is no such patch, that
test will trigger soft-lockup in 10 minutes.

```
root@(none):/# uname -a
Linux (none) 5.15.160-dirty #7 SMP Fri Jun 7 15:25:30 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

root@(none):/# ps -ef | grep rcu
root 3 2 0 Jun07 ? 00:00:00 [rcu_gp]
root 4 2 0 Jun07 ? 00:00:00 [rcu_par_gp]
root 11 2 0 Jun07 ? 00:00:00 [rcu_tasks_rude_]
root 12 2 0 Jun07 ? 00:00:00 [rcu_tasks_trace]
root 15 2 0 Jun07 ? 00:03:31 [rcu_sched]
root 145 141 0 Jun07 ? 00:15:29 ./rcudeadlock
root 5372 141 0 13:37 ? 00:00:00 grep rcu

root@(none):/# date
Sun Jun 9 13:37:38 UTC 2024
```


I used [rcudeadlock-v2][2] to verify this patch on v6.10-rc2 for more than 2
hours. The soft lockup didn't show up. If there is no such patch, that
test will trigger soft-lockup in 1 minute.

```
root@(none):/# uname -a
Linux (none) 6.10.0-rc2-dirty #4 SMP Sun Jun 9 11:19:40 UTC 2024 x86_64 x86_64 x86_64 GNU/Linux

root@(none):/# ps -ef | grep rcu
root 4 2 0 11:20 ? 00:00:00 [kworker/R-rcu_g]
root 13 2 0 11:20 ? 00:00:00 [rcu_tasks_rude_kthread]
root 14 2 0 11:20 ? 00:00:00 [rcu_tasks_trace_kthread]
root 16 2 0 11:20 ? 00:00:03 [rcu_sched]
root 17 2 0 11:20 ? 00:00:00 [rcu_exp_par_gp_kthread_worker/0]
root 18 2 0 11:20 ? 00:00:12 [rcu_exp_gp_kthread_worker]
root 117 108 0 11:21 ? 00:01:06 ./rcudeadlock
root 14451 108 0 13:37 ? 00:00:00 grep rcu

root@(none):/# date
Sun Jun 9 13:37:15 UTC 2024
```


It's about data-race during cleanup active iou-wrk-thread. I shares that idea
about how to verify this patch.

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
>  
> -- 
> 2.25.1.362.g51ebf55
> 
> 
> 

Let's assume that there is new pid namespace unshared by host pid namespace,
named by `PA`. There are two processes in `PA`. The init process is named by
`X` and its child is named by `Y`.

```
unshare(CLONE_NEWPID|CLONE_NEWNS)

	X
	|__ Y
```

The main-thread of process X creates one active iouring worker thread
`iou-wrk-X`. When process X exits, that main-thread of process X wakes up and
set `TIF_NOTIFY_SIGNAL` flag on `iou-wrk-X` thread.

However, if `iou-wrk-X` thread receives signal from main-thread and wakes up,
that thread isn't able to clear `TIF_NOTIFY_SIGNAL` flag. And that `iou-wrk-X`
thread is last thread in process-X and it will carry `TIF_NOTIFY_SIGNAL` flag
to enter `zap_pid_ns_processes`. It can be described by the following comment.


```
== X main-thread ==		== X iou-wrk-X ==	== Y main-thread ==

do_exit
  kill iou-wrk-X thread
  io_uring_files_cancel		io_wq_worker
    set TIF_NOTIFY_SIGNAL on
     iou-wrk-X thread
				do_exit(0)
  exit_task_namespace		

				  exit_task_namespace
  do_task_dead

				  exit_notify
				    forget_original_parent
				      find_child_reaper
				        zap_pid_ns_processes	do_exit
								  exit_task_namespace
								    ...
								    namespace_unlock
								      synchronize_rcu_expedited
```


The `iou-wrk-X` thread kills process-Y which is only one holding the mount
namespace reference. The process-Y will get into `synchronize_rcu_expedited`.

Since kernel doesn't enable preempt and `iou-wrk-X` thread has
`TIF_NOTIFY_SIGNAL` flag, the `iou-wrk-X` thread will get into infinity loop,
which cause soft lockup.

So, in [rcudeadlock-v2][2] test, I create more active iou-wrk- threads in
init process so that there is high chance to have iou-wrk- thread in
`zap_pid_ns_processes` function.

Hope it can help.
Thanks,

Wei

[1]: https://github.com/rlmenge/rcu-soft-lock-issue-repro/blob/662b8e414ff15d75419e2286b8121b7c2049a37c/rcudeadlock.go#L1
[2]: https://github.com/rlmenge/rcu-soft-lock-issue-repro/pull/1
