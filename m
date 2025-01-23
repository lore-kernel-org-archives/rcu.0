Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97E517C220;
	Thu, 23 Jan 2025 18:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737658716; cv=none; b=luG65ruOC0TSLjTyIXzu4242zJODxVitbtEPn8ogmlSAIR/fqJhe5z6PcuvSbXbSr6lggyHQBB7zW7rLd8lQ0y642f6OLTPtLSRBxA4fqngvlPTGHh/X1NJD8xFXlafcE692xOuVtyPcg5x4f0Nys2FlH97DSekz/6tdQ+ammmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737658716; c=relaxed/simple;
	bh=RwZvbgX910S4UG3GAt47ssRn0Spn1KbQiiaXn8iPpK0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWP/1gFJxZZXsAVjTsjiCU8pX/vJ29UF738CxCt4PgaJDt4QZQW4opoclEQklvUdGkhP6mn/eJkKw5AzvGrIk/b3dMqJqVzw1mB24q1iLm+14VrWkSfhPNyC3XgSGPIaYYwJsYka1X21C4iumnh/IrXV+z6BSSRwkjDQxdHRcfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QD1Mu12m; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QD1Mu12m"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5401be44b58so1466653e87.0;
        Thu, 23 Jan 2025 10:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737658713; x=1738263513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnQF6orToOjnS8khCdzt3y/vz48zz2lcz2DYFQDQYZA=;
        b=QD1Mu12mbcwnjq5yXQjTbTCbPImEwJIqTsP9fsG8lUiIp4b2/qd+h4PFarHb8L9AwT
         Rpc+ap5bwue2gywVnSW7uR5yjidKigbYNopQv/JKuvZLDZPeFVOrRIzPjIWo5eRCPWYX
         llgX4Nj19vXBQh/lO7dmEPvygT/hPcuu56ZMvOzHjGXNHcmxPwEIPqdsHizmjoMEZudA
         ZHfme5/cUrGlNTLwKHlpaHYHiPFIdv5YCRXTCraHVwz8HukKCp0bHEfOFdb8ridW3keN
         WaXH7+1aQmu3b5TTnfqpfwkd+prHnQyhmgVFh3PCEbzBJsDF6SZ6nYM5gkJBIS9+ANcr
         ZK0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737658713; x=1738263513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnQF6orToOjnS8khCdzt3y/vz48zz2lcz2DYFQDQYZA=;
        b=GLQlzVwYVqh+F6adHk/b6RHy5s7v6Ip95ZD6VIcrZg/JTLgCJkAa4abXFPVuhuaBQe
         9Y753n8WUIJ+PGxFgLNVwfEg80tJU10SE/2pha0Zm7La0p7QKXYZQC3CfWqsDLKu+bgI
         y5U6TMKXkr4dI4NXiNxQlzxDM/0V0v7AjqIvUsITF2kLEnKr0e6cfQh1x1SmnuhO1t6n
         6+4+CtcmEFB2BJI3oi7IwQnFO9qw0QO+wUEg03vdayWrSzl+tMRtUnD+QDzFvfzoS/je
         625k0V4EGe3pTMlyTU2f9bBVB3oAVRqibaNjdy6j02OhJr09GT5EJiVE9Yy9W34fvaSF
         NHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXccw/4R/XUTTix5T9kj4hA8bSSYBx2SLxv5GOXO2MkSAH7zzxSEK+7mJgm8PO4YcI1//YCmNg+ESgngxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTrCevU5zzOnyIqQAJfcNYIbhmgLKUtEYnD5YwvV9vDbbED4oB
	2jn7lgn+h3aB9nR6ivMWECDOlVx6liWOCQaaGZ/8rQdbaSzAgG7F
X-Gm-Gg: ASbGncvaaM8CLDxJgdIQ624qim0Ak6lpvUTB3Irk9ohQytcZIkQJhd4zFT49gq6ZO5f
	tUo5ZV6/TKdC0a8+3hYsZWVNtojtiQPSbxf9rnUP7/+j/FF/01kZIXxPvq2vzTChi8KDWSrELQV
	1eN+h4UTVpp8vlMOVRa9QaP43zK2Zw8l47vEHPJurs1yQfUg+SyMFVuJ+hleTjDyE2eAVCsSj3/
	9ZaB1t4UmXuOtkzwkLD3OtyZ8TTuBS1gI5OIV4foS2xn6sVuXFAY551ieOGbNxxZq1NVETQZ64n
X-Google-Smtp-Source: AGHT+IF7vFmZuDaTLDCmNgIIbMtb1JMs0Aig/nla69iRPjNnFd3xWEZdHUXKBa+ExJUMJotCbKF+tw==
X-Received: by 2002:a05:6512:3189:b0:540:2fbb:22cb with SMTP id 2adb3069b0e04-5439c221527mr9171939e87.13.1737658712747;
        Thu, 23 Jan 2025 10:58:32 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-543c8368497sm9644e87.151.2025.01.23.10.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 10:58:32 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Cheung Wall <zzqq0103.hey@gmail.com>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH 3/4] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Thu, 23 Jan 2025 19:58:27 +0100
Message-Id: <20250123185828.460836-3-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250123185828.460836-1-urezki@gmail.com>
References: <20250123185828.460836-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add extra parameters for rcutorture module. One is the "nfakewriters"
which is set -1. There will be created number of test-kthreads which
correspond to number of CPUs in a test system. Those threads randomly
invoke synchronize_rcu() call.

Apart of that "rcu_normal" is set to 1, because it is specifically for
a normal synchronize_rcu() testing, also a newly added parameter which
is "rcu_normal_wake_from_gp" is set to 1 also. That prevents interaction
with other callbacks in a system.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
index c419cac233ee..54f5c9053474 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE05.boot
@@ -2,3 +2,9 @@ rcutree.gp_preinit_delay=3
 rcutree.gp_init_delay=3
 rcutree.gp_cleanup_delay=3
 rcupdate.rcu_self_test=1
+
+# This part is for synchronize_rcu() testing
+rcutorture.nfakewriters=-1
+rcutorture.gp_sync=1
+rcupdate.rcu_normal=1
+rcutree.rcu_normal_wake_from_gp=1
-- 
2.39.5

