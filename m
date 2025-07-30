Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AC3185E7F
	for <rcu@vger.kernel.org>; Wed, 30 Jul 2025 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842246; cv=none; b=YRovAI6xJT85Q1rW/CmIfG+9MJwD7Oa0RG1XpXIZctbKxbvQo+YUjiR3V1Uz9dCzBoDVzglfEIsJdCE6Og/Ntv4FwobW6lLSgLzENGICVyopV0kaMzSsX1WhuVa912CVrT6IGHBwwZ7BAzUf2wQW4OLr6sf5uBHIOw8YcJjYgj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842246; c=relaxed/simple;
	bh=H0UUCMwPbauJFwXKf5FEJMbuxTY4gBIHnlfo177PUBI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tQZDdUPebEATq4y/PlZ7cuEyNMN2D5cnBVmlvnCgMR9uoZf3jwzhzrII8JdOV/+oXQrh/i2oYJEn7odt5KEUjt3aRp8UOp2Eboic2R9Vk8HUrYi4K93UawLkNsIDi4+dxsDRBHyS8cs+cgRXIYBCuFYBhg+nOWkItmUSnI55q2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iX+nsSS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iX+nsSS"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-74d12fa4619so5617762b3a.0
        for <rcu@vger.kernel.org>; Tue, 29 Jul 2025 19:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842244; x=1754447044; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Ci2ReqvExh5hUJsZr8hncyF/IZp83k8aCl7UPO5nf8=;
        b=3iX+nsSS5v4DmZb69+fiu5gmJYfkfoyjOal8kwmHI+haOZ1kXHfZ57fg0xA6T8c49n
         MNwtrJ1TdBC2IsRVCLxxppwSBhmhHlxZ3K4JeWr6FjSXpSAHdtNqjhnk9aqlDAfkvTX2
         GwaPRFB6IfGASpslh0gLaX6g6rWVubGt0teOf8/QD5+cVF1ZSzMoMO+CP6sx9lZRMiqZ
         quhHHohhVd4rprrtUIsK02siQC4G9wVhwdwGCyCnvvTaFk+6jxw98feP6OevdpTxMNlj
         HxtQVJM+idrlGUIxHBwzFARHy9OHT7nGKmuVsYRykVM0SKN6L5WzztIM8T/zS5HtBPzg
         JZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842244; x=1754447044;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Ci2ReqvExh5hUJsZr8hncyF/IZp83k8aCl7UPO5nf8=;
        b=qp5wYGu35dL/a0jFq09z9izI1QNLD8ialsPgMw4YKgFA8f/nC+8GgHaiCQSmews3uv
         1BneB3a5lIXCF/OTgz12JEn5pTPBmS8MVAAP9jtgwQ60eHRHxRsibOFhXz1OL91SovSw
         PFSngwjk7jXuIxDNv0W5cmyUy5axPte/CjVt25XD3fkDuMacZaixIa2RY1qNYqQutLaJ
         6M+Kx0sLbTQq75LiL3hcYNXDv7VyF3TdF87hRjM13TxtfVk3Ukvtb/hiOftGqwsUEkt7
         vLYV7c1sy5SBkECgaQGNDNXQSZlBsMeEAInJpM/ycMTChdXJvGsVqeaRvzAtbExXC+j+
         BLAA==
X-Forwarded-Encrypted: i=1; AJvYcCXrpI4iKb9btubvi3qre93TMf1DU3mZeUBf51oOH6gPSnh9JYfQqPYMEhqBdQa4KY9wghM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5EwZ8GiBQ4LPe72tcNVZlXfk0cg5e+3Kz9GYw/D1Iy8keS+F
	efk2FOD4TqXM4bBC/kuhQbcVIaWIIkUFhG57InCjgb8fH1oif4ee0HQaULEeAN4Cgczx4w4lWBC
	PVkt/Kw==
X-Google-Smtp-Source: AGHT+IGCk06yTemJIvRZYVkO5wpPDlMdnXl+JYzRbjc4qUTdc6uFzIoU4ooIBU7ilF26pnQ7F85gFRA5qrM=
X-Received: from pfhx21.prod.google.com ([2002:a05:6a00:1895:b0:747:af58:72ca])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1152:b0:748:33f3:8da3
 with SMTP id d2e1a72fcca58-76ab30c3c7amr2430894b3a.19.1753842243778; Tue, 29
 Jul 2025 19:24:03 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:43 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-1-yuzhuo@google.com>
Subject: [PATCH v1 0/4] rcuscale: Add debugfs file based controls and CPU
 affinity offset
From: Yuzhuo Jing <yuzhuo@google.com>
To: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yzj@umich.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Frank van der Linden <fvdl@google.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"

In an effort to add RCU benchmarks to the perf tool and to improve
the base-metal rcuscale tests, this patch series adds several auxiliary
features useful for testing tools.

This series introduces a few rcuscale options:
  * writer_no_print: skip writer duration printing during shutdown, but
    instead let users read from the new "writer_durations" debugfs file.
    This drastically improves cleanup speed.
  * block_start: an option to hold all worker thread until the new
    debugfs "should_start" file is written.
  * {reader,writer,kfree}_cpu_offset: the starting value of CPU affinity
    for each type of threads.  This can be used to avoid scheduling
    different types of threads on the same CPU.  The 4th patch in this
    series shows drastic performance differences w/ and w/o overlaps.

This patch series creates an "rcuscale" folder in debugfs, containing
the following files:
  * writer_durations: a CSV formatted file containing writer id and
    writer durations.
  * {reader,writer,kfree}_tasks: the list of kernel task PIDs for
    external tools to attach to.
  * should_start: a writable file to signal the start of the experiment,
    used in conjunction with the new "block_start" option.
  * test_complete: a readable file to indicate whether the experiment has
    finished or not.

RFCs:
  * Should those new files reside in debugfs or in procfs?
  * What format should be used for the writer_duartions file, and what
    documentations should be updated for the file format definition?
  * In the 4th patch, we see different characteristics between overlap
    and non-overlap.  Current rcuscale creates nr_cpu readers and nr_cpu
    writers, thus scheduling 2nr_cpu tasks on nr_cpu CPUs.  Should we
    consider changes to this behavior?  Or add automatic conflict
    resolutions when total threads <= nr_cpu.

Thank you!

Yuzhuo Jing (4):
  rcuscale: Create debugfs file for writer durations
  rcuscale: Create debugfs files for worker thread PIDs
  rcuscale: Add file based start/finish control
  rcuscale: Add CPU affinity offset options

 .../admin-guide/kernel-parameters.txt         |  29 ++
 kernel/rcu/rcuscale.c                         | 361 +++++++++++++++++-
 2 files changed, 377 insertions(+), 13 deletions(-)

-- 
2.50.1.552.g942d659e1b-goog

