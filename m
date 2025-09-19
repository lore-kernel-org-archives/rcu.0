Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F832F83BA
	for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 14:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758293459; cv=none; b=KtZ0ED5N4s98BilTlV9Q5IJ82C0AazaTLzZ1x8qmXXcfLqQ2nnfVPizHCWQoJ4WNqEYH8PWs6KF/pI97kn/EZn5yGEfcJMjlvdq2vQy/82ChHKp1YIaa/NSBJ4v+Cd5WQPUg78bcaT7tFyF0vv2vFjoEGVdGG5sAzrSOJf5GzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758293459; c=relaxed/simple;
	bh=gxbhOQrPen8wXKKo+NB3/QzXDeT+XwtG3U0ZszLmnqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PwjiyW1tH1PyMbu6ZQZfCbgneYlH9l+R78tlghyCbxXWLpBYs7Z0b2yx/laPy8u/bEafvNu1RY88eP7Rnsd5GZb4M4jLsILkFh3jPma+eW4+KziTWpI1eSyXD4n0oEpRif0TvK4daCurUzL2MOp3FA4KrFfJgUin2Ik2M7FHY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T+qr0ugk; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T+qr0ugk"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4687b41fb56so5029515e9.1
        for <rcu@vger.kernel.org>; Fri, 19 Sep 2025 07:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758293455; x=1758898255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=40YxYjMQup45mLrxpuaYiZa8fGkstQxo+I8VLpAXNI4=;
        b=T+qr0ugk70YwdKvPfk9ICGCJu2VGhgAwQSm8BVw187rNp6cQJWHSYo9/IjOYNUrkIS
         RCSTWICvLp1Haa5+KyYJb1ACKw26rNFW47kvXmDOa1AYK+1e4jQEr0cmaLIv9NlaMD5c
         zrjTJlODCTmO9w7yhJf+sY30xUhDN6L3RhOaipugvpuCPuEf9KQGLd3gEtWAG+o2bSMH
         jN/CnvAtzOpqTY/SPBBMuDOrJ3fewuP5bWgUXs9ZgB53HBaJQ+287GCaAunEtCttkzsy
         oARxWjYWG1zqjZZumyRxbiPLJLApGjNucI8i1VVj5V9waMz+E/RuclxPHQZX2Iurl3ux
         r/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758293455; x=1758898255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=40YxYjMQup45mLrxpuaYiZa8fGkstQxo+I8VLpAXNI4=;
        b=Z/TEDyHAw/v1fs+3KT0L8VCoWjY42vFWbvKMOssdtt+tCRWp/JGUNNSN2fzeQGNhta
         NGlp56w93YaR4IZMpp8OZkV71CBgjBHNgezp6kz4je0W6yKs4dqwkhIFr3MnSMCYktS5
         CYiG/2XE0C87fo1HWbmgeHy8LUOI3nCkPtjqfvrb8Bng9JRs5w6/Gfx/q2+XBbHZak+d
         i3CLyhZAuFstreHmK1C68i0rkxR+ASRth1wzpaf2hYarZchYPGTcb3hTrSaRKbNlyPVy
         h/+2EmPvpViAVw/y5o/RHrraW2OHfxSFmDXQxv5DwqbkdPT+3wIP2ijXnOvq3jSvHQD9
         RUtA==
X-Forwarded-Encrypted: i=1; AJvYcCX95CjJDWTGpdVtFnU1ngScQtJrihixD5ErGQyUVIMaX6m7ZrgrJk4E5955gaw22+IlfV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIlGMwgSuCAHQ/lTVuPbhoMEddmxYgDvxlbwOLiz4xeIbAba4b
	dNghyyQj+6sjb8vfKPuNL7Mw6FHBnKFwVo6BPhqbqdM5J/m9FzxvjCnRfbhqzGQ91yg=
X-Gm-Gg: ASbGncsT13N3KBOYB1EkOkQoTxxQZTQdlx8UXCzb/Bb/zcmgMBUfAm9wVg8JTsEzdvI
	PNpmrnnO1zT78nzhnrDUfocXj0qDoXfHzZEybo5jZvRU58hGxbo4IwnfnSw6tb2+0+WNgLK4x1K
	OXFR9BYFR5DTjg55EFmUB/lqgpFf0FQ/eXQUW3zb4I55vEdoH2prW4t/tg8yIw+IyY7aGzx/Xop
	pwewzWAkTWgQdBi+chL762SZhJYlNvAwAupe6vwjfSCi/Lci6qQY2tJg54qMxqgMYmkLblop7IQ
	LR3TSAnYPqKQiDBpNbBuzPWWrtIB/j+8pVuzfMGIkmIRQFsaNL7Mf0RkfZFCYB2hUeDQt5VhNzB
	YAlKOVVCcc1Hz8j1jkpxAgH6No2QV+0xFvDCqn70s95BsvA==
X-Google-Smtp-Source: AGHT+IHkEMZj8HTcCDLW+vs6fkV5ZntKhREeBeWZ6imHtnsAopavxOz9v2VSd5+jLowSXBfeWYQeAw==
X-Received: by 2002:a05:6000:2881:b0:3ea:87f8:da4e with SMTP id ffacd0b85a97d-3ede1d9f615mr6312213f8f.29.1758293455313;
        Fri, 19 Sep 2025 07:50:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f325c3c29sm86220025e9.3.2025.09.19.07.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 07:50:55 -0700 (PDT)
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
Subject: [PATCH v2 3/3] rcu: WQ_UNBOUND added to sync_wq workqueue
Date: Fri, 19 Sep 2025 16:50:39 +0200
Message-ID: <20250919145040.290214-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250919145040.290214-1-marco.crivellari@suse.com>
References: <20250919145040.290214-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change add the WQ_UNBOUND flag to sync_wq, to make explicit this
workqueue can be unbound and that it does not benefit from per-cpu work.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 4f3175df5999..7137723f8f95 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4888,7 +4888,7 @@ void __init rcu_init(void)
 	rcu_gp_wq = alloc_workqueue("rcu_gp", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	WARN_ON(!rcu_gp_wq);
 
-	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM, 0);
+	sync_wq = alloc_workqueue("sync_wq", WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
 	WARN_ON(!sync_wq);
 
 	/* Respect if explicitly disabled via a boot parameter. */
-- 
2.51.0

