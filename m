Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C173284B37
	for <rcu@vger.kernel.org>; Tue, 19 May 2026 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779219930; cv=none; b=aTiYuFQlbPVGksQNBYQOAZxi4Z1aT4AmPmxVhN1678fVe2iiMo7ej7N7vKBE/tVBhUtpiFbhVOUECCTL8ceTzGhGOdE2qUpBCaN90SlNCAOO4nJOXNKaOnvkBRu/+qgdmc2vXYDs2fhzKBNpt66+Vo59Cm5b4efwRuwOg3YCDEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779219930; c=relaxed/simple;
	bh=Su2fQRIlW05Z55lH+AXGvwujX4v8XAg/gmt2Q5NE4+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGYvdRtVrvN5yPAM2cctARmzigwtX3fvDIiiMC3E0baTjziDog+8nFnW/YSoNcpYS92XwH/b2CGQwItU95WeV07sRjUUce/Ng76g7WgTny/ufLKwgDzkcuC86yt6Wmd1BaEXt6Pw1BUPpkRxapkJPlaNh1h1iZt+ojAntwtziG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quyI9oUN; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quyI9oUN"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3942e9977a5so51720981fa.1
        for <rcu@vger.kernel.org>; Tue, 19 May 2026 12:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779219927; x=1779824727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UxEF/duoBLGd6Kf1OLrLZgjgYNWjAv4+Q4w+xmfG6iU=;
        b=quyI9oUNDF7nlJYIGwNLRmYbv7oVebNHx1w8Vqi3nxjAUZVbhLGFjtUtZR+xrqPYLk
         7Ibc3PAyVgHnBGfLCVLkHVViAtE2ZsvrmiABUH1yheFPhrf/11fYAkSj90qBtwnTdOof
         5bEqyV4vSCsPr2LHH+GetBGF0KWXOFrZ9n5X4QTPm/aQk2z8nXI29Bx6eQnXH10Lfbmp
         TbsVHfKaQwk6SqlGg0wYXLomoeCQ++oRS+DoCz+2eDGk/BSeJy0R14AkPij8hKjTOQ/8
         U4Z5LkwC/CYVpg5hsoiEG8YbV58lwjPM/pToYW7aZqcpU9nevbLYOyfJaN/Gm2F5SLP+
         cr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779219927; x=1779824727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UxEF/duoBLGd6Kf1OLrLZgjgYNWjAv4+Q4w+xmfG6iU=;
        b=Px3tnLeCj2D/dXhw8/UMSIYuUwvyTmL2qtJAJ7riHz00+N/XDf7CYBEwTJUspfpPXu
         e4HHICjzq9wkklTkYe4x1c9PNnrkJ6kXMsSmrh/j8Vrk+TpGZ0J0L2lhaxWzILrCCLCW
         RIx10fBI8sz2iOzlxTIlg8Vj/G97bbkm0yG2jKq4gQtbE39cjtzIvy1DssVoN+vm08Ea
         26ba4pnz4VRELETrXHCVOvjY2TqMk5P/J9FuypNaX/5SKHKlzjsv37FZWAUqoT6Zt2mh
         Gbw9Mf8SDxyQCDQW6f9+qp18t381ciILf3Y8d3g//zHCWXAT3RJMwzREqbG63gyFNtVK
         WKOQ==
X-Gm-Message-State: AOJu0YwFoBlwjFTmDrp6wNtB2n7k+29wdDsLkEyzHOzf6wgX7fKkpTP8
	/xDYs0u5pcmlE4n076p3Q6IJyPY3gsTvK/bLaiyxYZgBjMvSWb8vna7V
X-Gm-Gg: Acq92OEzWrNv5r7ur2W3rdl5LMAcDAusmlRkzaVcceBkWe69W+4Xcc/nx1nnue3l0cA
	kgdJblvSl4VNmTyRsalG9Z07N0dxeUm2Fn6NaIl2D08w6m3lf8VSk359tvIbpbX/LAWno3QXZOB
	7LvI0u1QcfvS2i8Cl+/0cKfvrwrXqqhj9V7L3xIXIAar2igJfRWVMfMtuEzMYXzWprpl0g2SRua
	+B8dkvw5zJt2d2Or1dm80mAj1G/J21QUQpxN+8RYMVKDGucW6RzvpbNbpR7oeCjeLlKXVD+jtxj
	dpTwROLTe3vzIxvjyuWa0LKcgWMZmARRh9TM1VqgPtL1bU0YbbR5P2PCKaYFKPnmdQUNrblbMM3
	cUebIXvmqfbVHLqQuuoV4RbBKjb477NFUqJu9J1l00BCKC3o8ejaOW/gpqgvEuwQQTiBYL3Igxz
	YzTbXNgw99xPriq1WjQ8diigeuCtzAwB0rWHUo
X-Received: by 2002:a2e:bc14:0:b0:38c:c0de:d58f with SMTP id 38308e7fff4ca-3945b5d49a1mr73237441fa.14.1779219926480;
        Tue, 19 May 2026 12:45:26 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3958827ec3fsm23558761fa.9.2026.05.19.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:45:26 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH -next v2 00/11] Candidate patches for the v7.2 merge window
Date: Tue, 19 May 2026 21:45:13 +0200
Message-ID: <20260519194524.158515-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!
 
The git tree with candidate patches for Linux-7.2, based on Linux 7.1-rc4
can be found at:
 
git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git
(tag: rcu-7.2-v2-20260519)

Please review and let me know if any patches should be updated.

Paul E. McKenney (9):
  rcutorture: Fully test lazy RCU
  torture: Add torture_sched_set_normal() for user-specified nice values
  torture: Improve kvm-series.sh header comment
  torture: Allow "norm" abbreviation for "normal"
  srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
  checkpatch: Undeprecate rcu_read_lock_trace() and
    rcu_read_unlock_trace()
  rcu: Simplify rcu_do_batch() by applying clamp()
  rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
  rcu: Document rcu_access_pointer() feeding into cmpxchg()

Uladzislau Rezki (Sony) (1):
  rcu: Latch normal synchronize_rcu() path on flood

Zqiang (1):
  rcu-tasks: Fix possible boot-time tests failed for the
    call_rcu_tasks()

 .../admin-guide/kernel-parameters.txt         | 10 ++--
 include/linux/rcupdate.h                      | 12 ++--
 include/linux/srcu.h                          |  2 +-
 include/linux/torture.h                       |  1 +
 kernel/rcu/rcutorture.c                       | 29 +++++++++-
 kernel/rcu/tasks.h                            |  3 +-
 kernel/rcu/tree.c                             | 56 ++++++++++++++-----
 kernel/torture.c                              | 16 ++++++
 scripts/checkpatch.pl                         |  5 +-
 .../selftests/rcutorture/bin/kvm-series.sh    | 11 ++--
 .../selftests/rcutorture/bin/torture.sh       |  2 +-
 11 files changed, 109 insertions(+), 38 deletions(-)

-- 
2.47.3

