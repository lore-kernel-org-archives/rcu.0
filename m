Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142CC1A6802
	for <rcu@vger.kernel.org>; Fri,  1 May 2026 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641391; cv=none; b=ad7BlGWaHXePPjCqGWD9eUjMmC0j7RBwwhmlnKGbdN2pz6qvzbq/QnxrM7RqH02AGpr2MUmcw3T5Lv8kUNQdjVx6kDRjf+EvTj6v1zv7260byd/fXzLaJv7gt133axARfCiAdhYqqtXGJLeDUDPoA70N3NNNwa8SollibhyCEkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641391; c=relaxed/simple;
	bh=+41dixGNeuD2dVMUdxAXfx15jbMsmmmXJdlPS6imaks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=joH074Fe1TE6H9UNwBtjQ9SpBaOxgupbD7sY2EUQDxQ0Fr0/kUWG/CPXoKVHnOE2upayKhQC4242QrNq1z10DJ87UkMMP+vdGOs6tHJxBvBJzSSkGNLKEU5aCYfJziidRApSugGadeVBvkBfx0/yQ/jemYcJ3kkYBuA6yT/rhOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcPox11D; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcPox11D"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b788a98557so16444275ad.2
        for <rcu@vger.kernel.org>; Fri, 01 May 2026 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641389; x=1778246189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IVOgkFgOSAS8LAKhbBot9eAfbt7830iNQpu7KWGXDJs=;
        b=YcPox11DYNdlg7+cyaDmxZ2QuZudai+jthZywhBSIL3BupfC+4ulUprSb9jJ6Nmj9s
         afQbKbxJPsa6qHanPSj+AM3xySsFUI8gPeDi8d+VQD4RO8HhZ7VsITjbluksJk6q2x/1
         apXsdvDN6vzfGDtXRA8jzvl5azXH74ROhbTXPrUJsU89PaoMJD8XV9nJHNzJXqaCYZZS
         vI6zJliET4YqQUCjR+6N5jq240zlRAbWsoUzat1GawvcW1WV9qzSLjr5XAKcOTLKZzST
         FPtM3rs5kdMolVQ/l1IWkjbaYcmgcOQB5mWosz6U5If1YELvNqy3aW1e3Up5mCP/JBrQ
         srUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641389; x=1778246189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IVOgkFgOSAS8LAKhbBot9eAfbt7830iNQpu7KWGXDJs=;
        b=OuHM1ka+gyfkrwFNrjYl0uiJP1MaWDRPeT1g//CddVGe9j2hGcw+izaMpzL5pyQO1A
         1tj0jc15ClEOEiYRmXbhmazL4UZpRbWWQHAvZpnCRdTBQ669aCryIa9+xrcIx+uAWtUQ
         Yp3EybuBPntoNwTIQJgRiFaCeb13/Me3efXIgyR8yCL1NjUi0RXuB9AwliaD1EYhrBK6
         PDrUxWjWtWokKnZW4U1fo4ZeZYsAnELbIoWjCoNoBXEoz64cS/bQKSB/413ZsUow4sXs
         qk1PE5jfrJB7RQi7F/ZEjsFIZpLspOHV5boQHocUHeujIBIVj9YDjXXaN55eX3I9z79D
         EXew==
X-Forwarded-Encrypted: i=1; AFNElJ+G4guVBQcgKidB4ziujoFzdiSCZ5ESoAl0DZFrcrvcW5JvVKvDC80hhccMWzVnSS5MCwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyheKcaba6WEiuOS1LXRMY63dcgHSGtutRwBT+ylGvYuAPpSpqZ
	8CdMPG9dTFFNiZIGTFzFQEkr/mooTNyIkZRVealM8A0acqQ3+Qo1eL6A
X-Gm-Gg: AeBDieu8ZiZVE6rgpDTvL/Oa9keFJhWrRpjPTFpEIPn51LOjVqUZBntpP7sIv1bqVDT
	4hMzMIZjPvHOrarj+LmJH26ac/2Q7RYaqrXm20pmw8j8uM30JE6k/Lky860Z+3dQqNy+X571vr7
	8e3BTQQob0mhybweR7SBgB4BsfpTv22DfxnF0/aKVaLR+Rq4nl2H3C3XQLKAmzamCEWA0FvkkIQ
	y38a3Qf5iVsTIXXgbqPxh4GuJRriFbC41nDHXi+Rl5kjMcCmEmGXw4ogeEBn5Bha7PN3SB2SPT/
	6j7/LUdLpW3rhyqBhIwZiCwI8sGgcp0iPXZW9lL96W3Z0tBmujDKdxWRSO5PjghGnVYrNO2xviW
	gPQnUwKk/9p3jwh1BTUWR1kgZV5xUJ/auL+Opywucsl1GOWkdRqkyw9m4yAKtk3sar2kKJ0jSi/
	EQ+ixk94J0uCNvqGjKh7TGu1JpQSM5ABY6H7wW2FMBawlyb/1tGYfiM6y2bGolvjY=
X-Received: by 2002:a17:902:c209:b0:2b0:c45a:bc2 with SMTP id d9443c01a7336-2b9a2354024mr50552755ad.16.1777641389309;
        Fri, 01 May 2026 06:16:29 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:57df:16f5:b7ab:5d05])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9cae59f62sm22438005ad.70.2026.05.01.06.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:16:28 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	rcu@vger.kernel.org
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.2 0/2] sched_ext: Follow-up fixes for exit_cpu accuracy
Date: Fri,  1 May 2026 21:14:55 +0800
Message-ID: <20260501131521.161852-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow-up of Tejun's suggestion [1]:

Patch 1: Normalize "on cpu N" -> "on CPU N" in the exit dump header to
match UEI output style.

Patch 2: Fix exit_cpu accuracy for the hard lockup and RCU stall paths
which were recording the detector CPU instead of the actual hung/stalled
CPU. Touches kernel/rcu/tree_stall.h and kernel/rcu/tree_exp.h to thread
the stalled CPU through panic_on_rcu_stall().

Based on sched_ext/for-7.2 (88588854c283).

[1]: https://lore.kernel.org/r/e7cbfc99b52b4b7059267bb81498179f@kernel.org/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Normalize exit dump header to "on CPU N"
  sched_ext: Fix exit_cpu accuracy for lockup paths

 include/linux/sched/ext.h   |  4 ++--
 kernel/rcu/tree_exp.h       |  2 +-
 kernel/rcu/tree_stall.h     | 11 +++++++----
 kernel/sched/ext.c          | 15 ++++++++-------
 kernel/sched/ext_internal.h |  2 --
 5 files changed, 18 insertions(+), 16 deletions(-)

--
2.48.1


