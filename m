Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F234C14EC6E;
	Tue,  7 May 2024 09:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074540; cv=none; b=uhmF+zVVAPtVNyanRBoVukVQ0PvImpDjCtscGnJpT+Ld4aU0hNOsksgWsRU/BzrFG/HP/hJ6c+tBjQvCuoPy+GkwTp0KecAgmh9anUr4wlYBl92ktNj5HTkBjjuC4t6KTmpTbw3CmDsIDMTgzhuT46k+nfBdXcKBVC82E88V1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074540; c=relaxed/simple;
	bh=SwXMBkAHbGHY45sy8CaLSa2Ff0hHYoq/irtkVE3Cotg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ja9lkR2nwVyzrrK9rfvFLKHV7tb1s+upofSCwLlP+gv4BM1sCi5knqKNejx8lx+cb8p7C5HrZoU+FMkQLmDsXsT40KSFyt62CLj9oWBtLtM3u+yvMOO64CnujsYu9eDPIhqArBdqDCZvN4xtehz1nFjiTsVuxhfVqCV+0KOiIh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lN87LEEB; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lN87LEEB"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e1d6166521so42219321fa.1;
        Tue, 07 May 2024 02:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074537; x=1715679337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbfiHnjmo3bJ9ltYrcPbr8miklUfUo24oHJfMl/NaTk=;
        b=lN87LEEB7Vlbi+VvSli5eJfGpDCzeL2JK9xXxWJNnFYjrHaXYLd/8QnUxDTxeam1oH
         GbH0ocqg8NJTZ7EptrDbr5C/nc4UED0cbiWU8zz+Pwi3mqVkOAEG/C6efkVxv6iGt+Q5
         odJhzMHBEElAPSA9IyALmKGyxHRBVdS7VBF03gs1rkKEtjEFkVQGMiR1DtuSTA4R/GsD
         2ofgNNa/xQowRVsehTEiOZHWj9Txjcp/mcnn6ejn8BV1WVr5j4VBm7y91fPfyYSfNvNn
         jsEx3qe89tVBrNlDZgYbFa/ld5VP8I3XxNW5dNbmo/OsxCSlT1oi0QOUyub7ZJBFP0e8
         uz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074537; x=1715679337;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbfiHnjmo3bJ9ltYrcPbr8miklUfUo24oHJfMl/NaTk=;
        b=l1+9GwISxZ1fjPs0zOH2egNAxOGBeUls5qLaz/QYL4Fqd48cS4u3P319B4AZDVKCYC
         33moi0+NoW/oUWjnSo2MzH9YiW2todH89I3YVV9pph9MapGDYIySxs+LKgpDlbawW1Td
         Wd0sltTw+Z4bRTUltZY/sZ4Yq025a6wuvRA84VCQs04cCONRYzuy/p/hSeSClEoEenGU
         SzcUYrG/exceDsyVO9CZ7aLY04ReDcHRzD+3JPdeINgP2vgelcrLKa8BZ9ogu1zEiYoa
         gnJ/pDuH9VSGY3Q/Jw9ZEjjeMO3CYiUJ8LhN7boYAoELOy35cwx1glZHCwq3bG2CknyN
         JJ0A==
X-Forwarded-Encrypted: i=1; AJvYcCXukV0f92+zwYstPMybmx4H59vrK9epAi5eFE45J1r7qO6pq8Otxj5usFk6I74AvSGy0cxMu6yUzmKRtC2lDYZu4On2Z/KXmHUNjmVo
X-Gm-Message-State: AOJu0YycWgK4vHLYGAaJz6R7omjY7a3moeYU5ragvidCionF7/hUYLc0
	LlE2B9RXFSK/RtTwSIW2IwJwjTjcORe9jlHFOnD9azVATy5/X97k
X-Google-Smtp-Source: AGHT+IG7hg4338f5EsIReZHWEu3tVUIcMMQTnQrYJokfQt195I6wm3Pv1x1RHLTY7b2gWAbPu/Xo8w==
X-Received: by 2002:a2e:4e19:0:b0:2e1:d95b:3735 with SMTP id c25-20020a2e4e19000000b002e1d95b3735mr628024ljb.11.1715074537103;
        Tue, 07 May 2024 02:35:37 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:36 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 04/48] rcutorture: Enable RCU priority boosting for TREE09
Date: Tue,  7 May 2024 11:34:46 +0200
Message-Id: <20240507093530.3043-5-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

The TREE09 rcutorture scenario exhausts memory from time to time, and
this is due to a reader being preempted and blocking grace periods,
thus preventing recycling of the memory used in callback-flooding tests.
This commit therefore enables RCU priority boosting and sets the boosting
delay to 100 milliseconds after grace-period start.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE09 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE09 b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
index fc45645bb5f4..9ecd1b4e653d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE09
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE09
@@ -10,8 +10,9 @@ CONFIG_NO_HZ_FULL=n
 CONFIG_RCU_TRACE=n
 CONFIG_RCU_NOCB_CPU=n
 CONFIG_DEBUG_LOCK_ALLOC=n
-CONFIG_RCU_BOOST=n
+CONFIG_RCU_BOOST=y
+CONFIG_RCU_BOOST_DELAY=100
 CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
-#CHECK#CONFIG_RCU_EXPERT=n
+CONFIG_RCU_EXPERT=y
 CONFIG_KPROBES=n
 CONFIG_FTRACE=n
-- 
2.39.2

