Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473DD4028F7
	for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218979; cv=none; b=Cy8GnsszasFPi5ewATnnFk7UyvpLii+22R6uUTYXxLExl5okXAN5rbQgp+V0jT668dh3+IU2WFZYBc2e4ShJsZZ7olkkx8TT0WRjZXRs1FS2zdaHcWMnyrVqCYNkH13IkUof0xfnxjdoPE62/vy623RP2dwCZLZlkvF0NhJWbCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218979; c=relaxed/simple;
	bh=94oBQ1E3TrOnZwIjKlOqHsa45htCk8xjD+RIr5rGE4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uqH93EIaL/j6+A8yIz+7jwlfAQQAamnnGCCwZIDfXCPQUsYyMf6UOmcdX+P0TpUlP4vtJT5Ij9oixqSruSZ44SRsKv63/b5RLXx5vrWh7Co7uaaUT2XXAfjPZyZpQZw7clpnRlP8wB1G5MLQozLZpUav/XgDDo16Pdj65TF6BW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLttaMpU; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLttaMpU"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so2863471a91.1
        for <rcu@vger.kernel.org>; Thu, 20 Aug 2026 02:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218965; x=1787823765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mz4ga/wlmpIJIqfhDzk1rmZoX+M5goupxtiu1lKt8Xw=;
        b=DLttaMpUztuV58+tMEVJ1QvPfz5t5bm/T5e4vJ0IKJUcHD9uf1X6n56PvRPw+lJY5l
         7AFfCE+9dfxSSvvWThknJPzq+Ee7PXnbQG0ueSIb08H1AQ5cr3eWNVxaQKE0mGS7YtUV
         l0E1i4Gs+LMNsV/ZJxQ4kXe7x4aqqUrtxR4lAU5gjdkr0c6zhghAf9AH44aTNTvZuRdK
         FNMB2Qt5CG2GxLBc156cCG88Zx/iyamZ7R8echUEFU+O2HvXCZJY7xTgk1ZOYKLljP8w
         /XZ6IUzNpqVFCfwYTiv7QQAyrK4sIARgHPYluiU6E0v5HE4wVyyWYcaO8beb81pnYpwX
         c0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218965; x=1787823765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mz4ga/wlmpIJIqfhDzk1rmZoX+M5goupxtiu1lKt8Xw=;
        b=lVn3iUzzitCUTFGwQtgrAFORoAFt4jH/kjoyltRM1KhR/bAqxmidouJRiLBJ9LXKzA
         v5oLpfFsEgS8XE90Lcu1EAYC+b91XAjJGFHYYBNqV3LGQhEAJaNTAacdqBgVBOWNt1iv
         6ID0L0oIQavXiVVcZYARf0N8sNAZ+RrpJpYURwMBNtnkq3AkhhTY0SxwCoR9h9HYnCfM
         iO+DntL0hZZ8KuvcBXZl3prbN0pA5K+lFXLGC6lh3PTCtxgxV2r7ZFmwAtEXXz2GL++J
         blJhRlXOnAE8B6EIXSuar1erV5SvBemtV9aNX7pGVXvUW33uY2OyeTF7Zz80PjHb6uZB
         JMFg==
X-Forwarded-Encrypted: i=1; AHgh+Rop40ZL0zI0ODiV/Ktbiv2gvC6700hjR0Q2XkIcwgZEEKb1JXUMhs3OJOwOAdfK9DnhgJU=@vger.kernel.org
X-Gm-Message-State: AFuF++lrwJkIoOnAs8VH+TLTulZR8XpHyBt2pE8RGrKmo8pY8AzlE84Q
	1Wt+dlRJcigxMAGaz/qTOujrTs3oxNgtZe+NR7Sg6du1o1+e/Y76n/7G
X-Gm-Gg: AR+sD10saR+jGCvuwjIpuwg+JH+UJgB+ezSdLbZg2s1Pe/FM2nNbqAsmd9W4/BkeUzU
	iOQNAkuiHjCVug4DNTUBYBbUVkQWDHgoiP2ox827d23UXNtXMoXrE6/qMqYnGEIkbajSE8IpFXU
	3sicT0PiIWxF/pvFiJ1I/wi85IrztNK+Ar3VliRVCkhLfa88orwQvxQhHknT4vfhnr3pF9tiuFr
	pv01GlTJ3aZ6R8I1nBBT1S3KPTN2/kCFBmXmM3C2uQkCSbK+w+WM+mUh7QKEUZYeHZpfTy4Onkg
	x94fsrrbsXTmvYpwoBhtooUkIkQYtJAg7wIxlu11G/MxiKXZJVebQXhzoYZkRS5tCHI+6yeJ33W
	IgLYDVKA1uj7IRemhg/oJYIszxiFbIJjuXqLaeN4S1Xv/aF6fiuWKmTBJkIz50A/Inni5Pw+Ssg
	j/SXdl3O86tGmbmEIUaNKcZJztcGF4u3cn4EmTv0NfPBAIVNPoeCzN23GgP5x85voRjt091lTPj
	EmPwVg=
X-Received: by 2002:a17:90a:e188:b0:38e:6d4c:14e6 with SMTP id 98e67ed59e1d1-39580a50d5cmr21560453a91.3.1787218964207;
        Thu, 20 Aug 2026 02:42:44 -0700 (PDT)
Received: from kernel.tail6741c6.ts.net ([116.128.244.169])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395adaf52b7sm494590a91.0.2026.08.20.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:43 -0700 (PDT)
From: Kunwu Chan <kunwu.chan@gmail.com>
X-Google-Original-From: Kunwu Chan <kunwu.chan@linux.dev>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH] rcutorture: Fix divide-by-zero with fwd_progress_div=1
Date: Thu, 20 Aug 2026 17:42:28 +0800
Message-ID: <20260820094228.540304-1-kunwu.chan@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <kunwu.chan@gmail.com>

When fwd_progress_div=1, the forward-progress test computes:
  sd4 = (sd + div - 1) / div = sd
  dur = sd4 + torture_random(&trs) % (sd - sd4) = sd4 + % 0

The modulo operation with a zero divisor triggers an integer
division by zero (undefined behavior at the C level, #DE trap on x86),
causing a kernel Oops and panic. On x86_64, this manifests as:

  rcu_torture_fwd_prog_nr: Starting forward-progress test 0
  Oops: divide error: 0000 [#1] SMP PTI
  RIP: 0010:rcu_torture_fwd_prog+0x90b/0x1160
  R12: 0000000000000000

The existing guard only handles non-positive values. However,
fwd_progress_div=1 also makes the random range empty because
sd4 == sd.

Change the guard to reject values below 2. The forward-progress test
only reaches this calculation when stall_dur() is positive, so
sd = stall_dur() + 1 >= 2. For fwd_progress_div >= 2, sd4 < sd,
ensuring that sd - sd4 is at least 1.

Keep the existing fallback to the default value of 4 for invalid
values.

Verified with QEMU/KVM: a 138-second run with fwd_progress_div=1
completed 81 forward-progress test cycles without a crash.

Fixes: 1b27291b1ea4f ("rcutorture: Add forward-progress tests for RCU grace periods")
Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 54bec8e21e71..ed2407e888b4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -3990,7 +3990,7 @@ static int __init rcu_torture_fwd_prog_init(void)
 	}
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
-	if (fwd_progress_div <= 0)
+	if (fwd_progress_div < 2)
 		fwd_progress_div = 4;
 	rfp = kzalloc_objs(*rfp, fwd_progress);
 	fwd_prog_tasks = kzalloc_objs(*fwd_prog_tasks, fwd_progress);

base-commit: c68271c3f83a46de3fca48d3aa9e27c4dec8e58a
-- 
2.43.0

