Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794849992;
	b=3MPJGvjWQDHADW3+qperdlbVPOBLRnOLCjbvb1froYMJ4tU6ov+qrsXZcixQ5MmElKmj
	 Xz55fh+K/gBB7NdJeUxQM7X9pY5q9npgQt5kvOxdR27Td/d9+9kc0trTuenwD1h0kQs3n
	 On/nliscgRfy+4NaVLVlsKjuIvgaTNGrw+8a+JKHq+pbmfALkBx9hyxUZgK+piqVOCigV
	 Q2dIYSH2WLfILN3JpsK6T+QtOG75iCDT8wvytmV9+7oEyUUXvkAa0CiZSnJ9i9/1hdNKY
	 N/z92TRzAnzM0VfX9RaSWB29l/2hWxY7gboVYJxJOPWSiqbADy/NobVnsc546Mzg9KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794849992;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VwzPKq1rV+b6+w71ZS1Job9j/J3TnM9GFJ+T9y7k9yw=;
	b=trbivRnhrAOW7Smhjp7v41k4ZZptJ7EZGahROLQyUV27nnCCkRX5QXcPMpTPWgaA9pwO
	 yawOu5bJLNnyBM1p59JWsp03AfHqlVgeWXvXr+B/M5bJxGKH1hJ3OVDqv5CbGoBMe4/kP
	 1bCv8Aj65TMFjrI4wJt0ozzsYFDCvMcYULWMdgCrqokTK1jmhesFh9wvUCEknMT6vdmdu
	 egL1GRWM0tMxXMEgPv31gl7rxTlY2FkSUIFmZ/oCmiDQ1n5punn6aSW0ERxfx21kYqkIv
	 y+Qu1rvXKEzNaVL98HMzBr9y7btAwwLVgMetq1iEyuZqAwz+FhQd0nGc6IZq/TyrY7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPa5dWZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F7606A331;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YPa5dWZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE4F1F000CE;
	Mon, 16 Nov 2026 17:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794849992;
	bh=VwzPKq1rV+b6+w71ZS1Job9j/J3TnM9GFJ+T9y7k9yw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YPa5dWZIKycZ7fo9N+dQm1uh65lERnhXXDi7T7nl/9UeMcy2+VsYEtNj7FtKjdOLP
	 lQLIUCWAhvEKqyEh1PCu1U4ANZIOj+AZfmPa19ZGbHmEcAHUZfQaPtwIe79s2Np5Ta
	 UFwnq01x/we2k816kLDPfBRIKDd4brksw4UokSi3OcQsFueK6Q2L11gHnnc+g3nvCj
	 ai+JJin0emY5qIaO+R6rQMkbkHJ8XlSztplrb/AmOa8QC0NbsQxyhibnuwuBtjZOmp
	 TRLcwZfiSgAP5mqOTfBSxuCatU9hrGgYCsA7CAu84UO6D8LMohcAnYs1bsa3lvZ4tG
	 qFGbMpNi72yLg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 47E5ACE0DDB; Mon, 16 Nov 2026 09:26:32 -0800 (PST)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	rostedt@goodmis.org,
	Joel Fernandes <jfern@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 3/6] torture: Avoid duplicate identify_qemu_vcpus calls in torture.sh
Date: Mon, 16 Nov 2026 09:26:27 -0800
Message-Id: <20261116172630.3845508-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
References: <bf761cab-7423-464b-ba8e-bd39ad0eb089@paulmck-laptop>
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

The torture.sh script assigns the return from the identify_qemu_vcpus()
bash function to TORTURE_ALLOTED_CPUS, but then invokes this same function
*again* to assign to compress_concurrency.  Save a call by copying the
value of TORTURE_ALLOTED_CPUS to compress_concurrency.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index cd023272137a0..0be8bb08c5ca0 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -47,7 +47,7 @@ configs_hazptr=
 kcsan_kmake_args=
 
 # Default compression, duration, and apportionment.
-compress_concurrency="`identify_qemu_vcpus`"
+compress_concurrency="${TORTURE_ALLOTED_CPUS}"
 duration_base=10
 duration_rcutorture_frac=7
 duration_locktorture_frac=1
-- 
2.40.1

