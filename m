Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABEC313D75
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293456; cv=none; b=jQSD5A5cnhXDLQUXEF/RLdrNEm34TAExugZ9t2lFWiUSuMZKXSDetKvUuyU0Vnymcxo0vQ+OuRHtDgWkvZaGVAmZPWWfvljpL+TybjSkoViPC/zp2Fjcxu1MN85EfEzWTThCLjF+f3z7VySsABVNZ4zc6nMVuhcunjyGa93i8Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293456; c=relaxed/simple;
	bh=eHLNUygB/VZPzQfrdpRf+rYxokJiHSA09acDWZOmNYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N5Ac/vCUKM5EpUBZigHa4E9mR7ULMPYDad7uGRVzTZAH/hu86vtOWYEi8yFoKukGcps8Oe8nw92yHhk3f/8esC5npGLl4NJDWBXu0QTwVxJQrsAxtYRerk65ti8wQCjsDeDc73lpSyGzNNHfFTwC2Egx6xs+y0vQAuR8bvdY2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OqEFGsEe; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OqEFGsEe"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so15401845e9.0
        for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 07:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293452; x=1758898252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gkKXFt050iBpd1q1kwfDPcpxL0hJR2YAHnRn43yZJzU=;
        b=OqEFGsEelFg5WnDC8mXDsGkiiwLv5+3ofPL9YH+UnRqSGJCLkFGnuwFT9Py6sSJKIj
         cBIXLrdn3hF0T2H04cY1FFnGMS2lXT1+amtza4/boR8fXGYbByofP2PMxI1TcXzEuPdd
         Jn8Poh73OOAJVTpbqNoLLLxRKDYWMkSHmB4XuT0RmyvX1rkYbivqwwQ0jMfOKovC2H+Z
         d2n7FyGxVV7YJsG65LRHYr6rBy2hWKpaYNZFY71p85/cMV9yoqt+7ZxAiACkBNvTG5tw
         biFHLsUVDNpvEDi5scY/uCeyu8PS0DtfAHNNaI/iVGjG6ncx12I5AH9HGp3AHLWDKqiM
         5X1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293452; x=1758898252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gkKXFt050iBpd1q1kwfDPcpxL0hJR2YAHnRn43yZJzU=;
        b=iLpqQiHJHYwJmLB1O/mhpEwY79rntpDfe7k4PxScLasLLE/th+QqzogsjqfmkOU4BT
         j/oP7tQfjVVwoAILGnJupaTroqihmFe5aYal6xY0L8r/NzyMPMGJXK4HmROQml9rgTU9
         eS0R3ZBPZ44APgTmay+My6A3bdP0VKlHEAgCbtJqKYLxGwN3Lp1/xiTizxpPuGwn4BcE
         /XL1hgDe1Yy97TGexKjLqArijCf2BSpTTVAjwDSS/nPABkPdEXfEqrywC+gocz1FSbmS
         ZN8LjWvqAA7AFiWMfmZuB1x3sEld4xmYjfiuE3KD/ViT3Llunv3JAXQKSuegWse2QJL+
         qW0g==
X-Forwarded-Encrypted: i=1; AJvYcCXD0303DqnXk1KfvAgK7X7B8N+2zAMGDXZMxNda8ujSjg9tzUYGm88WspO7X8ldE/A+OjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXT0gn8dsO0MnsB4bRTHS6l9+9PbLt86FzeQgkyLtJR66qq1R
	IGT6PzbWsfI75eK8FCXHywkc1OFl+4Fghh/OUY78psQFmmL1kGda/Ve9FGZxRrqwstoUj9113E9
	cWaagOfxRCw==
X-Gm-Gg: ASbGncvBenxenfvg4UrVzSo7gBQAcM0YRNdgHW1TUWlJOicxVWvKUy67YtcLGccOsJZ
	nzTqlS8J+YYKuBz03JCqCaLvFcTZgJTLbr4ev2bRXQ90/BU3QvGuKpYunGTXiMii12Wcq8OeIHs
	v5x5zVVG+a/ZEUl2CLUQRPjnbC7u397acGcbtG01dYHcWuegTCkK6TJ3mkfwShTm/++jADBzveU
	NvqQKyu0kZy4HLUNVyY3vp5S6250xX9frZgVzKyJTutHE5+SfkXr/sopvOgVZlaKIr5gj6OkR4G
	QJavNlogO5Z18jF1RdZccf1CKt++gGbx0NkXw4v+zqF4h7OfN8pTq+dLWszlOzN7V/XUkZsoXB5
	Zx8VcLvRiDaRD5k427ntLvk3K2AickBtPW2Zn4pXNAD7InQ==
X-Google-Smtp-Source: AGHT+IE0AyRQFy027O0we9IFGaJ57T0mN5jW/Xm8OltK/XV8i7+HDlJxVmBQqOlUogJN4zAsYSHkmg==
X-Received: by 2002:a05:600c:3593:b0:459:e398:ed89 with SMTP id 5b1f17b1804b1-467e6b64adbmr33591565e9.1.1758293452249;
        Fri, 19 Sep 2025 07:50:52 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:51 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jens Axboe <axboe@kernel.dk>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 0/3] rcu: replace system_wq and add WQ_PERCPU or WQ_UNBOUND to alloc_workqueue users
Date: Fri, 19 Sep 2025 16:50:36 +0200
Message-ID: <20250919145040.290214-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

2) [P 2-3] add WQ_PERCPU / WQ_UNBOUND to alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.


Thanks!

---
Changes in v2:
- removed WQ_PERCPU from sync_wq

- added patch 3/3: explicitly use WQ_UNBOUND if WQ_PERCPU is not needed


Marco Crivellari (3):
  rcu: replace use of system_wq with system_percpu_wq
  rcu: WQ_PERCPU added to alloc_workqueue users
  rcu: WQ_UNBOUND added to sync_wq workqueue

 kernel/rcu/tasks.h | 4 ++--
 kernel/rcu/tree.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0

