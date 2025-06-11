Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB28230BFC;
	Wed, 11 Jun 2025 17:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749664625; cv=none; b=fzTey1sjGQTALcqC73JQP+BfJnqh5XCKquRtbtEHbFCYuBy0I4kTNnYYq/qlkoLFfnADgVgXZ9bhxNuQ3z/bixABcbVdo2Lw1Dd5jJtdhej9ql9vCPVjkITST+KKQPNv2OedU1yShSdjEHvJ+yRNIWv6JJ3Qxj18FAeEQn9aa8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749664625; c=relaxed/simple;
	bh=v6iRsPP57nIYdEk8qNOUGvCsohAwwc+Ea6W8AxVp4+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOr7RyF0ssWYXv63zwRmeHIg3SJjO3KoS/MA4nsTbEbMnIWVqEhl/1RwSJp53E/NJoZeYRQ/zRgTcAvA3jHBkalvSTmoCVFz3Ba/M2t+IDLvmau8+nSnQHKbJXQrhw0MA9nZ5wocV/boDstWfzjIElgRf3UrVUXt6IWpwPC0v0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mdDLLbL2; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mdDLLbL2"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-551ed563740so28027e87.2;
        Wed, 11 Jun 2025 10:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749664622; x=1750269422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZbQ0I0nHPCtbX0zdSPuXGOFcOttQEYz2NZV5TQu1rm4=;
        b=mdDLLbL2eg+MMbh3TRmU6enCH7aznTXdXfjDNISzqSleMCTM3ZI2kUTWANn7P8SHVy
         TBvcj/boRcFCf7nKGnfBiHxEudxSNBrSWsyftGHcwXMC/PGpwgiX9qPBnt3emk2CIxsN
         n2SqZGUlNG2kKn2YH/R4oBtl5SOdG1QE9ntLaPFVBFohPQb8a7l7fh1deEqlzPQ5b/++
         f6iIkyp37jqun99YccDP+3jMCDaMtIBTPGI8suy8VMwzWR3HT5k5LQ/E2KdQu+83SmVP
         s8eX2u3hzoCMDNKRF+58SV/IMXpVjUz8RlEma2c0WRAofHU2T/eV2JDNWRMlg4ab1GUs
         YZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749664622; x=1750269422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbQ0I0nHPCtbX0zdSPuXGOFcOttQEYz2NZV5TQu1rm4=;
        b=brxKJWdCBSZxdeePs0f/23SZCw4dp92LF8eJX/RT/nZplddwMJwuMNcxfurzwjkByz
         JYGDK4CLyuYtrdwECPeWQ9SaK+j87l2LgaqmOmrHGY7PRweq1v28omGtZ1qPjNZmFbQh
         YIS/oQAuIeO7c02JjYzMja4yYo3qnO3nuIE1ou4cwj3NjodtcBbUXsxffU8Smc9udARo
         zDKaqOC0MYWVRTGxt/PiuDPvOQZHlugD7pXNPJ1q29C6Klu+t/KzZ4MYmj6CfgAxHKOF
         cHij3+iVGnRAyEZ1Uvy9qYm6MQ8EzTMQc+zVtfZF6P/5eEvaIIdm5oaItqiC4jz2v8uE
         BEoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVExezKdlms6/TyKMpyaBY6djvK5eLEXUfu6MevHLkuytn1aJ5MmX5CYMiiuRGTDdkbtNpYTS14B9FBxLw=@vger.kernel.org, AJvYcCWIbvo8C2YLX7gfF+1PDbjb6ifc2O+RaWyc4hWYJ5cHC4N2po7uo93cNL8yjh8IlbTOuAoq@vger.kernel.org
X-Gm-Message-State: AOJu0YzVy9k8uzhT1WH7nNwEiFTcOwOYcnVhulg/TrjEnLjy0PxThMLa
	DhCCne6MPLJWYAgcNt31nUWaAYmm5wFU1FUgTq8E4owgRWqKlpJv+vIx
X-Gm-Gg: ASbGncvz2T/4/m/NUiBKm2LPqCUWRUBcuz9vqiw7+l3A/PAarWDKylDl60J47xUTmkk
	qzapqOKJrA2QC1I8l22/1HnXgg305Q5pLOWBGUhN1r/+4HXnYz7yrgOwruhTLjtmvUk9cP1WOEw
	34zotzb6nMXBQhhgT8SeYmiyL0Y2Nb61yYmk9NY7McRCXlqp8cJ/yKFd6S2LJQXXWNya5kiI/Mk
	BTshlZAHJy6bAujmNgigHknETqRjCaqchL5CU2BaeXOzcs0FCys5zbxDK0vW+821rivAngiIgCk
	8KhfyqJZGgyYZVEVe0XxLRbLT1GTU6TZ5TSisZlKKu4DhESzjPIgKO8l5w==
X-Google-Smtp-Source: AGHT+IHl0VTWOLF7zFh1MYFDI3ApOi6GZM4f8QJzudXpo28dDOe7EvC3Cq+rUPzv4eJylrqnmKf3Yg==
X-Received: by 2002:a05:6512:2304:b0:553:2c93:6140 with SMTP id 2adb3069b0e04-5539c0a047dmr1430699e87.9.1749664621312;
        Wed, 11 Jun 2025 10:57:01 -0700 (PDT)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5536772a899sm2003603e87.170.2025.06.11.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 10:57:00 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>
Cc: Joel Fernandes <joel@joelfernandes.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: [PATCH v2 2/2] Documentation/kernel-parameters: Update rcu_normal_wake_from_gp doc
Date: Wed, 11 Jun 2025 19:56:58 +0200
Message-Id: <20250611175658.91361-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250611175658.91361-1-urezki@gmail.com>
References: <20250611175658.91361-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the documentation about rcu_normal_wake_from_gp parameter.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f1f2c0874da9..f7e4bee2b823 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5485,7 +5485,8 @@
 			echo 1 > /sys/module/rcutree/parameters/rcu_normal_wake_from_gp
 			or pass a boot parameter "rcutree.rcu_normal_wake_from_gp=1"
 
-			Default is 0.
+			Default is 1 if num_possible_cpus() <= 16 and it is not explicitly
+			disabled by the boot parameter passing 0.
 
 	rcuscale.gp_async= [KNL]
 			Measure performance of asynchronous
-- 
2.39.5

