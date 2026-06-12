Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82930313E1B
	for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269033; cv=none; b=hWDKsw1qNfcx+Zl45++wfnvNowv+SxyLdFieNEF7NHctwmuAZ8C68BPkV4PlK/yMfzey3b6ws8t4ZR+vAJ0sqy0hnunqoXDUCzX6KE6M3BCAvM9x7RsRRc99pjoi5BGHqWTmbvzYJDtRdw6nVl3f1gV5sr7zoQ7DXAxmSrkjjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269033; c=relaxed/simple;
	bh=KoJsegr9DmG5M2Rty7B1sXD+hiU1rnGFNHNbw8EHjwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S0Sfiba1NVke/nRVWehKtj5G2YBbOHsWm8OSS2majEVfPQLpDvpOMcjg0e407MkyNRnQPQu+d0IUEJ6CQxKI82Do8X6NbQqlbpBoWOY3zwsgqckE1UtJvPPhPa1emaUJRs7tnHq1202p6i7V+nzJ6c5fQ2SpkzZ9WondGlj/VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVdpDU9K; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVdpDU9K"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa7bf3d512so1224899e87.2
        for <rcu@vger.kernel.org>; Fri, 12 Jun 2026 05:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781269027; x=1781873827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvaZ5HlOHSO5zQJxZKUc8oM8+QiyYAbLdN6j2pAHr6c=;
        b=fVdpDU9K79atcu+nyW4YcQsHAGgzvc6L2r2AMz7sXgkw38rz4dDAZLT8xVS7LqfPs+
         32lGPko0YhiTwmi0uqiiuAC2rW4VIQNWWKdPLMjhdkbjC4msopCkb6QQ4wM7sjCW2wd+
         d0l+DjtpUtIHVhZjlfAXjQCi58DI4UkBmF9iVnB7d+NgUY1kufZ0HIRCNQWSqy2tBIgd
         xiRdE0F1zbgsIqZDzZT/+tamkRN64KgE8vKOtzMd9q6LEB+zhWB400sEbznP5vTgU8wD
         rs0/9y+Ik6PhF9A3yhF4+mO+k7qD/kiARb/22V8U2+0BZrbxJPEeSwBkBR2CjAY53o3v
         skMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269027; x=1781873827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvaZ5HlOHSO5zQJxZKUc8oM8+QiyYAbLdN6j2pAHr6c=;
        b=nRZUjdE+Lq++yFPgWWS3VNZ+k+gVph2JvHfvArFZF8/5jD4mKo9+Qze97eck34+5+6
         blObqKHJKGWMxIoGA/GUo8vrdwUovw6Byy9gVTEXAqtKVJx51SWJU7x3/trrCgDFvRfs
         ybY8oLOQUzBLx5UKw8OFrECt/u41Z2ww0fJRtMyNzpZHrc4WVswgUlMI4T9kK0XO6vcK
         CI/2QDAHhlUiwG6LZ1VzatT7ikiX8wWfQmAswVnzf//fdD2DMGG8h1P6+n+0qbIqxirr
         AbfdHbFSQW6ywxPFZJHO/p9kuBLLp7G14NAkVCELt0O4xgv5j1xZM7iLeY4+i7VF1IWD
         GUxA==
X-Gm-Message-State: AOJu0Yx+OF1PM3AMe6IX4+OmU8QWfABrkXWxixoYgL6X06Yd6B0E7wek
	h+SvV+IA2MNcbxRAgxcOSPFo2eb0w/XiVMEx+QKuDoABRIn2UkSL3vNi
X-Gm-Gg: Acq92OGIFgnOwXBCj7Zw92b9hUGNxxu50pJ/ZnePmi2Uc6qC/2UX7e6DM60YsGtOGWj
	LlPE1v7gpLKcT2aRjOb9VQ767H9Usz/xlcnu01mr7y4aI+t7ynCxtCb9RnqrOEzCNKpBsZIsSjK
	WlOOLNkChkbMBs/DoR5uHtj8yxt6V3fFZXRmxfgbiNledZqOssjEkcd/lmvpoBGl939s6C+XKqN
	QW6hNSTyTPo/4bqJZWG35UeZPNvQaTFV+XCovbRece1BZS6Fn8a8g/mOM0OnygDzKHWv0f6oSgu
	jlW99/zfGOflfEJ3MjBZMFXpi6vy71ZWo3652NUsQ8dKHqtOUiqJ6tM7FcL/ArshwAk8wvePJH4
	nJO6VMcRJ+IHzpGlid+o3faalEdiHgIWq3uhKZW7fu7W8Slrw2/c1jElgICA3VJ2u4iUQ2lp0MQ
	tefYF/HxCSvPVZE8Y=
X-Received: by 2002:a05:6512:66c8:20b0:5aa:73e6:b6f8 with SMTP id 2adb3069b0e04-5ad2db8288dmr696418e87.35.1781269026446;
        Fri, 12 Jun 2026 05:57:06 -0700 (PDT)
Received: from localhost.localdomain ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1b499dsm520311e87.78.2026.06.12.05.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:57:06 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [GIT PULL] RCU changes for v7.2
Date: Fri, 12 Jun 2026 14:57:01 +0200
Message-ID: <20260612125701.59340-1-urezki@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus.

The following changes since commit 5200f5f493f79f14bbdc349e402a40dfb32f23c8:

  Linux 7.1-rc4 (2026-05-17 13:59:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git 
tags/rcu.release.v7.2

for you to fetch changes up to e853c1b28580ea93fda3cd729e440a3fc16fa647:

  Merge branches 'rcutorture.2026.05.24' and 'misc.2026.05.24' into 
rcu-merge.2026.05.24 (2026-06-02 19:45:08 +0200)

----------------------------------------------------------------
RCU pull request for v7.2

This pool request contains two branches:

rcutorture.2026.05.24: Torture test updates. Improve kvm-series.sh
script by adding examples in its header comment. Lazy RCU is more
fully tested now by replacing call_rcu_hurry() with call_rcu() and
doing rcu_barrier() to motivate lazy callbacks during a stutter
pause. Add more synonyms for the "--do-normal" group of torture.sh
command-line arguments

misc.2026.05.24: Miscellaneous changes. Reduce stack usage of
nocb_gp_wait() to address frame size warning when built with
CONFIG_UBSAN_ALIGNMENT. The synchronize_rcu() call can detect
the flood and latches a normal/default path temporary switching
to wait_rcu_gp() path. Document using rcu_access_pointer() to
fetch the old pointer for lockless cmpxchg() updates. Simplify
some RCU code using clamp_val(). Fix a kerneldoc header comment
typo in srcu_down_read_fast().

----------------------------------------------------------------
Arnd Bergmann (1):
      rcu/nocb: reduce stack usage in nocb_gp_wait()

Paul E. McKenney (9):
      rcutorture: Fully test lazy RCU
      torture: Add torture_sched_set_normal() for user-specified nice values
      torture: Improve kvm-series.sh header comment
      torture: Allow "norm" abbreviation for "normal"
      srcu: Fix kerneldoc header comment typo in srcu_down_read_fast()
      checkpatch: Undeprecate rcu_read_lock_trace() and rcu_read_unlock_trace()
      rcu: Simplify rcu_do_batch() by applying clamp()
      rcu: Simplify param_set_next_fqs_jiffies() by applying clamp_val()
      rcu: Document rcu_access_pointer() feeding into cmpxchg()

Uladzislau Rezki (Sony) (2):
      rcu: Latch normal synchronize_rcu() path on flood
      Merge branches 'rcutorture.2026.05.24' and 'misc.2026.05.24' into 
rcu-merge.2026.05.24

Zqiang (1):
      rcu-tasks: Fix possible boot-time tests failed for the call_rcu_tasks()

 Documentation/admin-guide/kernel-parameters.txt    | 10 ++--
 include/linux/rcupdate.h                           | 12 +++--
 include/linux/srcu.h                               |  2 +-
 include/linux/torture.h                            |  1 +
 kernel/rcu/rcutorture.c                            | 29 +++++++++--
 kernel/rcu/tasks.h                                 |  3 +-
 kernel/rcu/tree.c                                  | 56 ++++++++++++++++------
 kernel/rcu/tree_nocb.h                             |  2 +-
 kernel/torture.c                                   | 16 +++++++
 scripts/checkpatch.pl                              |  5 +-
 .../testing/selftests/rcutorture/bin/kvm-series.sh | 11 +++--
 tools/testing/selftests/rcutorture/bin/torture.sh  |  2 +-
 12 files changed, 110 insertions(+), 39 deletions(-)
