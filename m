Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976009;
	b=rbDTXBuUo7pqE2/16b3M299oLCYVSv7wZctKaj32WEojvbeNeUXPjMfE6icdKybav7Y3
	 jiXW798jq72c0m+EU6FesdBHSVk4XNbu97OH8vUoDI2WSpG67ioFnvXbSSJG6d2+VA3sv
	 sIqk6DLMb/icKdmnA1W8qzENgJhvQda04uoVKnHkmRuyZ3YPHW0k9GP+DoY+l8pqe/kFk
	 V2mC3ZEAkmqBGwWyAzkV7bKKy1X3fFIPUR61MEE/7wm1WE4Q91Gi2QD97aIdo3Sh6dtaZ
	 T812XcdlGPO375z/Cu6tpMGlqKXHH48f8o1u5qVOQWW6zXiYtrXng7LLT/DsnuEyuWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VX9HHcw2MD3Gr5P9Ztz5qkm8xBMf/5Qk5NjDMCVJWCY=;
	b=v/+qjJvv7oGsAE8TPT22vgZStDq7GW2+kIK8VCzPIFVq9/9MzheVANg8kA5xlOduMs5S
	 HoG1uWOKPgQGLuepkjFrUtkutgQUYZvSxAHbJnybDuAXD/tCkobE7a2HTPf22LkOTKHNa
	 dBAqoTzaL1UsliJvwF0Ri99rUkB2Oq2EC7i8xb5QSG68bXKQfNfBYgYrF1YBM7nj5scPf
	 b24S9K0CEaPTMZowW6bNndbkjrzjO3Wamwi/FxgaI4oKS/5Pchr+GGvA96j0HqXA0uZGc
	 c5w5DAr9DR4S2B7hnqqzPZVG8A9qJl6sB5z1UXdFo4hzbe4WBgwnHmrus1kVNYjuxjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NUYt/w0W";
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD20606A32C
	for <rcu@vger.kernel.org>; Fri,  6 Nov 2026 14:40:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AD20606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NUYt/w0W
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-370a1bc464cso40886eec.1
        for <rcu@vger.kernel.org>; Fri, 06 Nov 2026 06:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793976008; x=1794580808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VX9HHcw2MD3Gr5P9Ztz5qkm8xBMf/5Qk5NjDMCVJWCY=;
        b=NUYt/w0W2yY1B6gWSKEl+10ga20huiLHLffz5z4qjB7JIyJPgCftSaIOpzZVsmZbF6
         kbMrpLlpxRL0ijlUh0rDGdGS6j5S3PSXz37V34ZppjT33ADpI5+vBf3kwoCtRoeoA3AL
         jRvoY62taTx8LV3FLSQB3i+W3Ujo36cOMWdicPoxJBVQUn1toC7vbjmPHg8LNyLnETnc
         n2CV1b2+TQV0J6wTi6yNkzS0k9QuCkeNpECIR1uAM5mAZKqoPoMQ96agbDzKdfVZtb/W
         buDtY2pELMedR9BcZ4TQzT8+jq/2XhYpVO8wk41OeXE8KoqDOvdCzSCw6UbBFEFbK4cc
         KKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793976008; x=1794580808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VX9HHcw2MD3Gr5P9Ztz5qkm8xBMf/5Qk5NjDMCVJWCY=;
        b=BSzP9n9QWMqSrI4k5+SQ7bPC1i6Pnm+638G8+h8IpMO/RMSWX3j6yRQ3W4zzuvsMM7
         hymOlxxHZHeZsNcqNs5tNgd0yQa/epVZQZ/cTDmA7SMl9ZcQeyJtq4X/iYYluprBP4Mo
         RFjcsNDkiiZ6Ri0oNzZZ+QwEu3WjOzpvrP9KibQbdmdj/IZa4/VB09TQgEsmwgMhxvw0
         /AXOQV3RbhDeSVRlv13t81wd/IoTVOn+CC/hfMmiZ/WTch2qcrYad3M3Ui18SoCVF0U7
         Hm9bvIzff7MokTUVUSUj3e4sOTzDDnvkJCLhuube3arky4HuRNrqE+NjDSFEUlWQUAX1
         J/pw==
X-Forwarded-Encrypted: i=1; AL+hErErSdtRNt8XJRiAPjj0TwCa+UZ62QYVvxpW6J1nRrRGGy9wHWFmHyEsbiUCv+zVi8m7+P8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LGNZraVzhG5ErEpitMKjQ00LfaoIE5IxTGpVrbj+iheksTTjI
	zNF8FGv4PuJLVGgTvP0eN0vZ/18T8KS7x5UkGqVg7vaoPHAYXi2z/YV+
X-Gm-Gg: AYBFou2tre48toOPbJHjkMZjWUXtwBpZyKbO/IPc/78ACmnlQZDscm8ZNzQcugv7IIu
	B/or00gmlvyIFN4SZlE+SNPM9cvHc8LitvJ1kHDV0wyopHbqb3GH0pQBDXZuiNPTcWH5D0yTQYV
	icr+IeTF0QM999ddeVY8/xwbPcgCRZyFMNqAzYkwpmtjQ7ljXMKpWJr5KUnE6HnXfz843q20Xsa
	EGkIaF0h3mhwK8+MimmqqP+CKXmThqDDBMGHJn4dnxCFoqKmDD75RmJldOBTvc4ROXfkfnn3V8K
	pfPNQkPngKQb7tnK8pdBFqx2ByGdQ6+yA9IYItTssQ4sfFtWOMCgFjKHIrQDpdw3/pUejTkTCwf
	xyjvSIzg406EkEeDVRk1JWYeR7iV1bybBP/q0J/bPNP7ke4tj6YuHcUbMRhnle6Z6+IDqvKo/0f
	aucOjROpA08xSA3g8xP2uwHAEhubi8QG5sQ+gsjO4XQ1Rf91RNaVuX91zAZRmYPjvmxtFnqwGUN
	holX3GQR9xWEdYUj/EhVTH/nCQuWvRbg6+sQmYK9tnvON7mUJa8yK99GCi6k0yZQhehNABTv79T
	WDGfn4I41or516bwSysA9wCiKBZXjq4VDwpDmag=
X-Received: by 2002:a05:693c:608d:b0:36a:1e50:e45 with SMTP id 5a478bee46e88-36f7681436cmr4458864eec.9.1793976007904;
        Fri, 06 Nov 2026 06:40:07 -0800 (PST)
Received: from kernel.. ([216.195.201.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa6a649csm7182068eec.26.2026.11.06.06.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 06:40:07 -0800 (PST)
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
Subject: [PATCH 5/5] rcutorture: Add KASAN aux-stack verification scenarios
Date: Fri,  6 Nov 2026 22:39:13 +0800
Message-ID: <20261106143913.3627722-6-kunwu.chan@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106143913.3627722-1-kunwu.chan@gmail.com>
References: <20261106143913.3627722-1-kunwu.chan@gmail.com>
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

Add one rcutorture scenario per RCU flavor for the aux-stack
verification test: TASKSKASAN01, TREEKASAN01, TINYKASAN01,
SRCUKASAN01, and SRCUTINYKASAN01.  Each sets CONFIG_KASAN=y,
CONFIG_RCU_KASAN_AUX_TEST=y, the appropriate flavor choice, and
the kernel config needed for that RCU implementation.

Suggested-by: Zqiang <qiang.zhang@linux.dev>
Cc: Kunwu Chan <kunwu.chan@gmail.com>
Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
---
 .../selftests/rcutorture/configs/rcu/SRCUKASAN01    |  6 ++++++
 .../rcutorture/configs/rcu/SRCUKASAN01.boot         |  2 ++
 .../rcutorture/configs/rcu/SRCUTINYKASAN01          | 12 ++++++++++++
 .../rcutorture/configs/rcu/SRCUTINYKASAN01.boot     |  2 ++
 .../selftests/rcutorture/configs/rcu/TASKSKASAN01   | 13 +++++++++++++
 .../rcutorture/configs/rcu/TASKSKASAN01.boot        |  2 ++
 .../selftests/rcutorture/configs/rcu/TINYKASAN01    | 12 ++++++++++++
 .../rcutorture/configs/rcu/TINYKASAN01.boot         |  2 ++
 .../selftests/rcutorture/configs/rcu/TREEKASAN01    |  6 ++++++
 .../rcutorture/configs/rcu/TREEKASAN01.boot         |  2 ++
 10 files changed, 59 insertions(+)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01.boot
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01.boot

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01 b/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01
new file mode 100644
index 000000000000..c115af0446ee
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01
@@ -0,0 +1,6 @@
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
+CONFIG_KASAN_INLINE=y
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_KASAN_AUX_TEST=y
+CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TREE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01.boot
new file mode 100644
index 000000000000..69ed391bd61c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCUKASAN01.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=srcu
+rcutorture.stat_interval=60
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01 b/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01
new file mode 100644
index 000000000000..e42387061bb9
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01
@@ -0,0 +1,12 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_RCU_EXPERT=y
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
+CONFIG_KASAN_INLINE=y
+CONFIG_RCU_KASAN_AUX_TEST=y
+CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_SRCU_TINY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01.boot b/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01.boot
new file mode 100644
index 000000000000..69ed391bd61c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/SRCUTINYKASAN01.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=srcu
+rcutorture.stat_interval=60
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01 b/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01
new file mode 100644
index 000000000000..e4c1d9740498
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01
@@ -0,0 +1,13 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_FORCE_TASKS_RCU=y
+CONFIG_RCU_EXPERT=y
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
+CONFIG_KASAN_INLINE=y
+CONFIG_RCU_KASAN_AUX_TEST=y
+CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TASKS=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01.boot
new file mode 100644
index 000000000000..b9b6d67cbc5f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TASKSKASAN01.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=tasks
+rcutorture.stat_interval=60
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01 b/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01
new file mode 100644
index 000000000000..219e599fa8f3
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01
@@ -0,0 +1,12 @@
+CONFIG_SMP=n
+CONFIG_PREEMPT_LAZY=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_PREEMPT_DYNAMIC=n
+CONFIG_RCU_EXPERT=y
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
+CONFIG_KASAN_INLINE=y
+CONFIG_RCU_KASAN_AUX_TEST=y
+CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TINY=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01.boot
new file mode 100644
index 000000000000..d5dafe68a5da
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TINYKASAN01.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=rcu
+rcutorture.stat_interval=60
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01 b/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01
new file mode 100644
index 000000000000..578711fb2d43
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01
@@ -0,0 +1,6 @@
+CONFIG_KASAN=y
+CONFIG_KASAN_GENERIC=y
+CONFIG_KASAN_INLINE=y
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_KASAN_AUX_TEST=y
+CONFIG_RCU_KASAN_AUX_TEST_FLAVOR_TREE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01.boot
new file mode 100644
index 000000000000..d5dafe68a5da
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREEKASAN01.boot
@@ -0,0 +1,2 @@
+rcutorture.torture_type=rcu
+rcutorture.stat_interval=60
-- 
2.43.0

