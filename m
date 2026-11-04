Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811413;
	b=fq3nm7X6zCs1stj2nW7ctpir3p0xGgwOIOSeH8mtejFMhe7Vs1vmNcpjzkV/rTDHvbcd
	 I01lqzzAgTj1JCQn/Mv5/jdoVW/F9aya2iC9LvGW+Nu5wXm+EPTz1VDcDAZcQTB1UHkDn
	 twJRMf5hoh8wLkwizG14yUjfRAnHDMRr32/NAzPG9z3Rw70FESCEaN0r+puQOiSvN3Nnz
	 99oJ1u3JKlP/jTJXk8dsgU3JrvzOy4S2DcHiFg912FyU64Kn/OlUhSuyYu4LA/Gyt36Ex
	 30sjo2wnOzdJDda0/edFOXyhgzsU6DrujUnsGMeijcN5N+kAXNq+bIbTGHWYUHkjx0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
	b=KZLlY6Fm2dJTyqqcHrURXtyDtR15kEs5Nt6Rt9lfCn3o3vmtLjRLs3zFSfXOfdIm66se
	 6HoKLVciMOFdl1onKUffbGXAyTw+5TfeVlS96UOl4dUlcQAiCq34NX5f28wI0jcviJv67
	 Z7pGRa/zVwn2AGojIq7N7+bpxtQEEdFdL58yjhF/05EmM2YO5yPpBG3bSJopdtV2+e75B
	 hhU5IN19zA1ZbWmk+nG5iqs0OPtLTp+UhJuyg/KaGlqoQmOuoAM+Bm5hdyJxwjT5HnCE2
	 Ur6QgZki3eIHQY/oOXaAqefMKNHou3a9zIlAAE/IGxp2jjoB+9N69agueccC6StkV3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCP9s8Vr;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE23A606D812
	for <rcu@vger.kernel.org>; Wed,  4 Nov 2026 16:56:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE23A606D812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kCP9s8Vr
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-36d6765756fso734512eec.1
        for <rcu@vger.kernel.org>; Wed, 04 Nov 2026 08:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793811412; x=1794416212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
        b=kCP9s8VrCg/13i0ZvqMzZuUmktyH+GlFZ2KrzEozRxYNjxwtUFfqQ4YcRch8Qeyk6u
         Hyn0u3av8Oq/ekitd88yUopP0KS5X3nfx5bJN9XLDCihsS9/B+LmIOjoIg8kMGHp55AA
         itpmpYPOnoIXeErCCDxkUnG9ddysA9lPc9P+UN27efB2O7duIM4/z/uptdK27yKrupJl
         wGzjO2kl3X2ToG59tSS1CSXqYjRi2kMx/7bC8MIgy1Ghv4RO4R5aSoIy5zr5UcYM7Z0f
         APMXkid8qQKM47Pb5yXyT1eLecZbbRtPU2rV+l7kFLzHqUXv5g7AxolJjZR1ODawytlm
         oxsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793811412; x=1794416212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Gn7Vn4SwsVH+p5VUqdHL4flc2b/Z4fswSqRV+byEjsE=;
        b=DsqeVxLIFMgAG+MhKTAf2nYYnz+pw5bVom0NdJm6Jd4Zu8Ac5x1tYm2bKyE/R984rh
         5f4+FGL8ipHvwTA2aRsio75xb4f8RvFIfXHXC/ie4FtUGM5zEIjWDo6kz6LneQ/ot7JC
         lWB69c8zrRzCQJIottGXRHi/b0rUlfvHf8cnjtz8jFix9u3fwYX8txVfW0HM04jOBX9O
         8mP+i1wmg5Fe/xg04MtxNC8DoJmoqyFo5XW2fp7YAuPwi9NgoNKDuwAyYcr1ADLzXoWm
         hd4vvq3XRRSdoyJ6AezqUw+nGVq3ZjC9/E9PZjxA/LY/s8ZNFH2qjlw3dBAVyN4c/FIn
         w7GA==
X-Forwarded-Encrypted: i=1; AKwUvBxtRzkMDRQcCD+3Rk/VHLjQdUBZ9xTLhBMoDY6u61+7LyKw0z4tlxcVXPVLSdvFawVJRhk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/uY894Qh8b11NgY2mR56V5LGhrWzmoaf4ajmKoLRkMaz6MB3mi
	csoJPg5IESuNrmQx4c2eGeputBbnWC7gxX5YbwcYtB1OveCu1Ybm42vO
X-Gm-Gg: AYBFou1abZ/uNOvsoH0WfMCA1jrgmj4Luyd/AlGR5xCU9a/jT6K6tEit9BiOl2LFKZH
	6n5yio8RXovxSXkcE3mupE9iMyBE53krJ9UjTHblVxBauQ5uW8M2BupVi8YSLftRXEtxwGNykxc
	UnHqkrLoygtzqzqgs7g+FbnqhspvcYrE4HM/jJWggADVb3CWaS5Szl129pIskgj3oSZUnbGAWgf
	0BtwDEsrDXYzsm7600ZpgxzgEsJzQFhUh+wSwQn2WUkRjXaX3n3GHYbIs53zciS8q9ML3f6lJFb
	a6ouH71RVQ2CAkQzVUJLpxorQBe5aiVMBl/1BmDkB5I+1oXtNuiVWpccrBOLEirEQx41S0xloch
	Fxm9olH2d8edMDEn8M+rX0KhZTfEExIbpWNVkr8tP/phCXqtb4fTFj2wdMhp9QXzt8rm9wqZso4
	ss0730f1plGpnQNnGuLxVKtfGMBi6VVm6qU1sUHTGfOEdo8PFL7Hpfvfq53ZCl3ao4adX6U9Wt1
	EAZywYxQsr/Qz/+4+Z5TxDpx1jk7O9Q9Wa78n4NUJAuIj61K1Nqs5SjKD8pTOab9YtfgrF6A9L5
	d8kNCvN+ObVfSzJ8ubogw4NTWYXBMnWFvULHqCg=
X-Received: by 2002:a05:693c:88d6:20b0:35f:8c5d:5928 with SMTP id 5a478bee46e88-36a4244db5emr23827711eec.30.1793811411412;
        Wed, 04 Nov 2026 08:56:51 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm9019567eec.13.2026.11.04.08.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 08:56:51 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: paulmck@kernel.org,
	boqun@kernel.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	corbet@lwn.net,
	mingo@redhat.com,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	josh@joshtriplett.org,
	urezki@gmail.com,
	dave@stgolabs.net
Cc: stern@rowland.harvard.edu,
	parri.andrea@gmail.com,
	will@kernel.org,
	dhowells@redhat.com,
	j.alglave@ucl.ac.uk,
	luc.maranget@inria.fr,
	akiyks@gmail.com,
	dlustig@nvidia.com,
	joelagnelf@nvidia.com,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	longman@redhat.com,
	rostedt@goodmis.org,
	qiang.zhang@linux.dev,
	kunwu.chan@gmail.com,
	brads@mainlining.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 10/28] hazptrtorture: Add 128- and 256-CPU configs
Date: Thu,  5 Nov 2026 00:54:28 +0800
Message-ID: <20261104165504.2430480-11-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104165504.2430480-1-kunwu.chan@gmail.com>
References: <20261104165504.2430480-1-kunwu.chan@gmail.com>
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPU128 and CPU256 configs for hazptr-stack torture testing.
These configs exercise the shared-scan path at larger CPU counts.

Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>
Acked-by: Bradley Morgan <brads@mainlining.org>
---
 .../selftests/rcutorture/configs/hazptr/CPU128   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU128.boot        |  1 +
 .../selftests/rcutorture/configs/hazptr/CPU256   | 16 ++++++++++++++++
 .../rcutorture/configs/hazptr/CPU256.boot        |  1 +
 4 files changed, 34 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256
 create mode 100644 tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot

diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
new file mode 100644
index 000000000000..079b463607e8
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=128
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
new file mode 100644
index 000000000000..1d09a6446080
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU128.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256 b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
new file mode 100644
index 000000000000..b00a984977f3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256
@@ -0,0 +1,16 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=256
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_HOTPLUG_CPU=y
+CONFIG_SUSPEND=n
+CONFIG_HIBERNATION=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_DEBUG_KERNEL=y
+CONFIG_HAZPTR_DEBUG=y
diff --git a/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
new file mode 100644
index 000000000000..1d09a6446080
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/hazptr/CPU256.boot
@@ -0,0 +1 @@
+hazptrtorture.torture_type=hazptr-stack
-- 
2.43.0

