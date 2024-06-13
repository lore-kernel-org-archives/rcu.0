Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A1EC8C7;
	Thu, 13 Jun 2024 14:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287358; cv=none; b=rzlXyrbOqxnhn8yoshfilr0U0rnMoQp8UxUlTLwGO83PeFVs5FQc3UsFixO4iJdhK0D965WF6mhwdYolZYJbEcUVN9Ajw60vGGvmisuH4lWeMGYwiwMn+LLyNorcrYgocUKNtHUF7PIRqfl1mqIpkIPeKg0jVPsQ3t4WyJMKQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287358; c=relaxed/simple;
	bh=TX2oyhTXPxfZFiVOjv8PdBwHuk8hSm1dPmT+CDgKML8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PdW6nl9HcpW8nUKdIzKK5QDYMu6ejFTF4N70jwB5nqgZSIG2fF+OKD3JsALXyPiYp+UuqU7vcOwv7OWjd3qx2V9+3XUmG+8WbNt4Ux1c1JiTZHxpHqDjIIWHLrb/bN49FuyBDmo6TRm2wooayhJHqong5oxKi8o9MaiC5oI3lSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpYvXlx+; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpYvXlx+"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f7274a453bso10079175ad.2;
        Thu, 13 Jun 2024 07:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718287356; x=1718892156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWtyvPo/6fLi/OjiQ3bY2ZBeDe3cJfLA444SNUCSSlk=;
        b=BpYvXlx+BAs5WZ8cpiRpXogFWkrKYtORGheyUSaThmI2o9d26BqSwclQTzEFYvMqaT
         5Rp4vxiONRj1g79A/iDJKTDDi/7N+diW8lmsVhfNCAGZDrp9vrHkybW9F09vXoXI+tLg
         1M7ooIvJvWoQJ9mVLAK62ss/8lrvwrEtuwSj0AbdSgqRiTfw+oFXDPd7iZjKPjOWL4Yg
         u9A77aJEnMT+n5dklKlOsumKOCgiEemrb2jnAVF8t0gIlwxNLjeUAgG6JKQCkU/fziuj
         EGertJnlvLQfnk0VuFUOmtgnJu1d1IMUq8A8GWl4qNHsSmkZUAWkxpz2FfBLJ0jrswrO
         s0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718287356; x=1718892156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWtyvPo/6fLi/OjiQ3bY2ZBeDe3cJfLA444SNUCSSlk=;
        b=jULw61lv1cn2HY8A00upz6a6X8xtgFgWFMgc1pI0Z3UqFZE5Df3g1YwE120Kb8kFwn
         IGDaRmwMow3RPubMxLZ03VUJ0wj2KMVFouboKj+Ydq3uGTZ3Acd+dsZ7iYuB7qaQWg81
         ptGnoxr8wVWXm6OTuVQPcO0K12ACO2EoN2uKUQV3xLtuQWmk4zZWsar6aJ2axXfjZRt5
         L1DtaopYlUyQbTOGCHcuSVnluBgpE30fhsO6dxj9zaMVaANOeMpkZ13v8qeglPwDkxLb
         EHUKvAFsheXDkgjw2ayT7KMAB8vjHuTu7kenkvVEAsVgy0r/lRraaPmDpA0GKsdV07bT
         yZhw==
X-Forwarded-Encrypted: i=1; AJvYcCVHpML1foTX/wv2fjET0RI93wk3SErx7IMEfbJ5bVkCij/KmPe9St3X8/+D6+U41nkfLBS7UU2QNEfOsdGRN8rWY7EUaJnFn8fswxsba5BRXkg+pLZa7YjZBUMYO6xKZtGR
X-Gm-Message-State: AOJu0YyyUoh6/C1L2wG6Au0P8P5rTTVGaGw1I7qUJNc+AQlP8MeQC/EO
	7xH3srQxPV8MUIb1hg1za4NLdMeTYV1bYd8n2TXjL/rFGPB/q89f
X-Google-Smtp-Source: AGHT+IHc1Tw8CCWNXqy4BSPjb429D9OR6j/CA83snJuMf9eX+9nwQhy7lHgz6e1QcnYLA0VQdas9Fg==
X-Received: by 2002:a17:903:41cc:b0:1f6:ff48:1cd9 with SMTP id d9443c01a7336-1f83b7232ddmr56799425ad.69.1718287356144;
        Thu, 13 Jun 2024 07:02:36 -0700 (PDT)
Received: from localhost.localdomain ([91.199.84.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f59fabsm14111615ad.301.2024.06.13.07.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 07:02:35 -0700 (PDT)
From: Wei Fu <fuweid89@gmail.com>
To: ebiederm@xmission.com
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
	oleg@redhat.com,
	paulmck@kernel.org,
	qiang.zhang1211@gmail.com,
	rachelmenge@linux.microsoft.com,
	rcu@vger.kernel.org,
	rostedt@goodmis.org
Subject: Re: [PATCH] zap_pid_ns_processes: clear TIF_NOTIFY_SIGNAL along with TIF_SIGPENDING
Date: Thu, 13 Jun 2024 22:02:16 +0800
Message-ID: <20240613140216.30327-1-fuweid89@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
References: <87a5jpqamx.fsf@email.froward.int.ebiederm.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> 
> Oleg Nesterov <oleg@redhat.com> writes:
> 
> > kernel_wait4() doesn't sleep and returns -EINTR if there is no
> > eligible child and signal_pending() is true.
> >
> > That is why zap_pid_ns_processes() clears TIF_SIGPENDING but this is not
> > enough, it should also clear TIF_NOTIFY_SIGNAL to make signal_pending()
> > return false and avoid a busy-wait loop.
> 
> I took a look through the code.  It used to be that TIF_NOTIFY_SIGNAL
> was all about waking up a task so that task_work_run can be used.
> io_uring still mostly uses it that way.  There is also a use in
> kthread_stop that just uses it as a TIF_SIGPENDING without having a
> pending signal.
> 
> At the point in do_exit where exit_notify and thus zap_pid_ns_processes
> is called I can't possibly see a use for TIF_NOTIFY_SIGNAL.
> exit_task_work, exit_signals, and io_uring_cancel have all been called.
> 
> So TIF_NOTIFY_SIGNAL should be spurious at this point and safe to clear.
> Why it remains set is a mystery to me.

I think there is a case that TIF_NOTIFY_SIGNAL remains set.

Init process has main-thread, sub-thread-X and iou-wrk-thread-X (created by
sub-thread-X). When main-thread enters exit_group, both sub-thread-X and
iou-wrk-thread-X are set by TIF_SIGPENDING and wake up. The sub-thread-X could
call io_uring_cancel to set TIF_NOTIFY_SIGNAL for iou-wrk-thread-X which doesn't
have chance to clear it. And then iou-wrk-thread-X gets into zap_pid_ns_processes
function with TIF_NOTIFY_SIGNAL flag. If there are active processes in that pid
namespace, it will run into this issue.

Wei

