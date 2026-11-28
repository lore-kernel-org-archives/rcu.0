Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795876093;
	b=utwPGvAMn7/HjrvOH9w2p5O/lQk1VU2p6IwLg7dcZ6MSAxqNo1PCUExIOMRbX/ZOkFW6
	 65txnt0QDyKx+9+TVr1KLU4KNxo0w2fea5SxO0hPj84bt1i3iejZYQpNpaiWffHcdfDqZ
	 3AsYsPi2JBIXcNszmo+l5/lsL987OYTL45vJHBTHFdyhHV+qe06d2+V4geVTBPD1nPaRn
	 FiSsQiopTFIlR83K9dQtD9Rb3W8AfEKGoba2CUMknYZoG5oneJa6+TkDbtDj9GB7NZvDQ
	 0uiLEKI2ZRSN5CSma6GwHClMomQ9B7Hop2HYAwZWvRLNkh+5ksZwuqYFPmRK7AubjRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795876093;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0o84T4cIEODIdxIW03HBz3DMcad7hAu5Aie4F8icjdo=;
	b=0EUKdx3hVaN2XNgEA351yS6FQLsiDPXSneR3YldrduthZs7YNl1sP1zcOFxECxXMWjLS
	 yFhuiPfHKH9mMNa7LKp6XergBRlmKZbRa4Alwqiai/sOpmTPSE2VoEkhnUjjEZTKnbJ3B
	 jKAJT0xA5JV0M8L+7aqZ6gAy8mwki/iszlBvDdl8MXI1EuMRn4MTNmJMya2khjGFOj7qD
	 MIFYHb0dEgpWhufdvg4Yab/Npm65k+slQjeZPXN0iIjb+N05ZRqrTq+WZR2RjIYBub3mu
	 BXH1XWoqDc63dKemXhdBX47Yyr9eb82Apsodq3TBwfvrFeWErJrMpR5OIS2Inwfm8jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIJcUaxG;
	arc=none smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD32606A321
	for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 14:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BD32606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dIJcUaxG
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso3527679a12.2
        for <rcu@vger.kernel.org>; Sat, 28 Nov 2026 06:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795876091; x=1796480891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0o84T4cIEODIdxIW03HBz3DMcad7hAu5Aie4F8icjdo=;
        b=dIJcUaxGqzsAB+oWbEo3fQgPqrdi8Is0Smd4eL85KHJkI5D0MsdthAH+f+cpKczc/Q
         R5o2eqKAuJT6Gix1wpUMHMQIOiOqTzJRL6ZDvXyaZRgJFbA9FwF/yXKJcZtEbH/caJqN
         HUGmZ4b9hkb7QRMTU3xy3gE9KCAn9Cxabr69rm5D57EI6Uvf2zxizREqAMRRGtWKRnCy
         MSR1ahCsN0JaZ47PUxWR31MIRu08mevXnlpiCeySpTW9VddxMb3+OuJxMyFYwJ/uvZRg
         D70iNerv8E7rWwwFPCpdqyPY78MY565ZF03lZ8Jt+A8mKkZP9+g6wGCghdQa4FCsaGYD
         4mQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795876091; x=1796480891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0o84T4cIEODIdxIW03HBz3DMcad7hAu5Aie4F8icjdo=;
        b=yWGBDxg4exah6t0HUjfAknYLj6G6Ns2jYzCf/IM7NyAJv/gMkGyuH8WfNtV0nJBc+b
         CyDGsZDJp9Lkz5nMB3fDRTIrPcpBaDfaRR/esPGpa8dZSuTqnVwQgtcsCSuJclCjCt4w
         YOx3J/iHjl1NW3uPd7imNX7rK1QrnGg+o04UitalnDmxgsz2I8Vw3aaEgauB4gapX2/o
         iGgwH7vbXvd4WOVfxstUP2TaV1eVcK+qY6eornqQo7ozQ37uduJVfpy06oaI7tTryugK
         venLu2Ojcykx0ANa8/ECRStrTaM64glKhCi2bnl5dG+cOOmsMYvJWHhU3gedWJGlUPAN
         r91Q==
X-Forwarded-Encrypted: i=1; AL+hErFU0RhC1Q+vvhsEyNqO8d2OZpCJJ4vabSBKO1pDp2ODXdW3EmRFSfix6YOMEK3ev5FsYq0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YftV2lyBow+IzIdDjBMLxXoZQYaOXUKlfykSz8ht0H7nyI7BG
	/+hs0i6uMtUUoxJyivvtGjxtaVy8gdcmy3c8/76msyFJTxkLUb8AsJM5
X-Gm-Gg: AZFdTZc5KMmD7CEpqB+tWYT+5isGk9HgblLWlu8wMRZ3hW5ey+v+SPW41o9c5sVffLJ
	ibs6w2fM2Oe7aMPo+gESOgS+1JXeKBwM+GObZDqLOc7IqLf+O8q4aYKkDiF2smLxwdCb4FaxcM6
	a1oYZTmF+Cgw2y338l9ViV6SC0RCv/koZNVkf4hi2XCY1v7K9OqbaZrYiX5qBZoFy9I4fxaU+/x
	KM0HXVi8sYu+dzZ27WJiZmfUleyj23szPKetleAgxhpaGX4Zdlihvg7PtNZTpSjWl2RojztnqSn
	PLh3adgsB3+FErwNLbl//x5LtqXqLOtc0uavsyBtKtJLSRr+AmY3o57tdCIhI37kAAXmQ6GT9O6
	kvBLQ6gJJmtT+fKuZLSPB/3o9GsirgRZpJu+sVMO66TARQXRdduQ92Gehwn5ZbwqVgfXQ+r3KPD
	JcVrtP/GiMtP7e1k1RIwGdW3PA775ZjkTgLFwgWR1yXP6tgUQPLCj+xXIbEHt5MYndX7MmlKZxZ
	yBc+MaEduVN3aLhEAEiJ4ZnUKt9NNlRAcqEF6JWh0ubxlM/Npct6I0rICoWyOaenzJNmxzWZz+A
	VlFRTCaRqHVumdKj012yi/w/CmuBzKgu6D4KDtg4CACLWtKVBZHhWoZgI8GfyaPhUK+uU7HmuXJ
	4vi31OcMhJ5zFTO+f
X-Received: by 2002:a05:6402:1e96:b0:6ba:2f05:2508 with SMTP id 4fb4d7f45d1cf-6ba37ec0a65mr25175886a12.39.1795876091074;
        Sat, 28 Nov 2026 06:28:11 -0800 (PST)
Received: from kernel.. ([191.40.25.3])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba36e35ca6sm12448436a12.4.2026.11.28.06.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 06:28:10 -0800 (PST)
From: Kunwu Chan <kunwu.chan@gmail.com>
To: dave@stgolabs.net,
	paulmck@kernel.org,
	josh@joshtriplett.org,
	frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	boqun@kernel.org,
	urezki@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	Kunwu Chan <kunwu.chan@gmail.com>,
	Kunwu Chan <chentao@kylinos.cn>
Subject: [PATCH v3 6/7] rcutorture: Run KASAN aux-stack checks from torture.sh
Date: Sat, 28 Nov 2026 22:27:28 +0800
Message-ID: <20261128142729.3756679-7-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261128142729.3756679-1-kunwu.chan@gmail.com>
References: <20261128142729.3756679-1-kunwu.chan@gmail.com>
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

Invoke kasan-aux.sh when torture.sh has both RCU-torture and KASAN
testing enabled, reusing the existing --do-kasan switch, the
torture_one bookkeeping, and the --configs-rcutorture scenario
selection, so the added kernel builds scale with that selection.
--no-kasan disables both ordinary KASAN and aux-stack testing.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Suggested-by: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 Documentation/RCU/torture.rst                     | 14 ++++++++++++++
 tools/testing/selftests/rcutorture/bin/torture.sh |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/Documentation/RCU/torture.rst b/Documentation/RCU/torture.rst
index 15a430f5111f4..8c8dcf6449bf0 100644
--- a/Documentation/RCU/torture.rst
+++ b/Documentation/RCU/torture.rst
@@ -244,6 +244,20 @@ As with the intentional warnings tested by ``srcu_lockdep.sh``, ordinary
 diagnostic; use the dedicated check to distinguish the expected report
 from failures.
 
+``torture.sh`` includes these dedicated runs when both RCU torture and
+KASAN testing are enabled, as they are by default, using the scenarios
+selected by ``--configs-rcutorture`` and 30-second run durations.
+``--no-kasan`` disables both ordinary KASAN and auxiliary-stack testing.
+For example::
+
+	tools/testing/selftests/rcutorture/bin/torture.sh \
+		--do-none --do-rcutorture --do-kasan \
+		--configs-rcutorture TREE03 --duration 2
+
+This runs ordinary KASAN torture with TREE03, followed by the dedicated
+auxiliary-stack verification of TREE03.  To run only the auxiliary
+checks, invoke ``kasan-aux.sh`` directly.
+
 Kernel boot arguments can also be supplied, for example, to control
 rcutorture's module parameters.  For example, to test a change to RCU's
 CPU stall-warning code, use "--bootargs 'rcutorture.stall_cpu=30'".
diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0498fce14ccd6..98edd2f3e747a 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -514,6 +514,15 @@ then
 	torture_set "rcutorture" tools/testing/selftests/rcutorture/bin/kvm.sh --allcpus \
 		--duration "$duration_rcutorture" --configs "$configs_rcutorture" \
 		${qemu_args:+--qemu-args "$qemu_args"} --trust-make
+
+	# Check intentional reports separately from the ordinary KASAN bug hunts.
+	# kasan-aux.sh supplies its own boot arguments and rejects --bootargs.
+	if test "$do_kasan" = "yes"
+	then
+		torture_bootargs=""
+		curflavor=rcu-aux-kasan
+		torture_one tools/testing/selftests/rcutorture/bin/kasan-aux.sh --configs "$configs_rcutorture"
+	fi
 fi
 
 # Test atomic SRCU across Tree SRCU (SRCU-N and SRCU-P) and Tiny SRCU
-- 
2.43.0

