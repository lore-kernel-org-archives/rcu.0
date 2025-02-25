Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2AC267F4D;
	Tue, 25 Feb 2025 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740481227; cv=none; b=hj58KgwCFkyq0GjSaZt4wNqWvn/tAX/9Fd+OXkPJy0QXyFnpYUtNiqAC/EonUxDIOrLX24neO+DrUL/+33PD39jpP+6zOnGyHZMb9We3Iyf3dqRJlhi+uJsY3to4VmI9jDxUGDkb4ItvbWmRn/M07scC56fK+zazUi3E7SCgOTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740481227; c=relaxed/simple;
	bh=sCuflgFUh/45tShowZi3ebLKyBuj3+UPfLcwZ/CRsbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cLza+1tTOiYhpChYNx7P7jTc31Tre65Uw3yZMWszrPQJSob0hJLNIvbxoOzRYOQDMlepiLLyL4NVLlqtaECu/XNqmmZkosPqWBcuhbrEMhPlmwXAuV+tj0CBSvi8ITFdkswjMteme5W5yBKPfchpt9dg9MrkvtAk9CG8ii982dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dbj0C96D; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dbj0C96D"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5461dab4bfdso6525263e87.3;
        Tue, 25 Feb 2025 03:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740481223; x=1741086023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=Dbj0C96Dhw2tHrfYDpY1HGtY7aCDtprZTI1XdNJJexbBUPBrem1Y+5kJ1QMdwOwjrL
         7cLxAVE/OavYW5qZHbjHPnIuz72XGzQgIwJoDNryISGbctiUe8mzG9mt7WT7K54HZBAe
         3fVPLvA6ZG5Fx7tgocp2b7Q/zefzDExL3UMcP02bC8cJ+fQagWzVMR/nRomI/0GforrG
         3rRHiz0Q3PGjguOYghFMGVDPFPN/1zg/B97l9nRztwtIlYKNx0xxvmtxfsxT61SxDRcW
         oVgkQHCudFv8sXaEHXmzUBLjKTkZru7nwNcAo2v1aukTSsRGRAL8SYxT9pSB7hwhaRc3
         ZZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740481223; x=1741086023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8AAp3JK/Rr4QIILXNDXheLWWABxs1/zeQyrDjipUFA=;
        b=N1IRdLvqKoJx5b3HbFqb0FqJarddMC6oOn0AnLbASuUFbpGYZ7xQIY2yk4OW9Lo0fM
         nKmcr1cfWUOEwlzPA9GPBbtDMavtVgF6sTAarHk7CXPkVZ6D+o5TPjXn06HaSglj41xA
         EKjkWWIiGCAq90NbAK5R2C+fFw4Mj/Hgj6rPXznc8a4JyruD4pL2MOY9Ew+xiQqlBuoh
         Dv/RrWWmhWCoqGmycjUExhm+GXKGScebM0Vm/xavL1Kg1ve9r1d8qoywhcAcHJJE9p2D
         c8o12DYBZ8tAryRr5Wnd+McblXQbg647fUFmZt0e7DhD/22gUimMxkcnhVaqSNEMHVoM
         dKww==
X-Forwarded-Encrypted: i=1; AJvYcCXQswzNROtGuGkVd7nJDujr+NE9GG0Zyjt0NgW16NJteiJ8Zui7OzQoms9ttxTma4+TY4XG+1R/RwzYvT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYC6pOYTC7yKR68FnNiAlL/qP3VgfV0AG9miS2HfI4xrjMgVLj
	jCsK1B3eLI9LWZrT612DfcoR5Ks9EDCuOLiYZYOk3r0daBsEQtxB
X-Gm-Gg: ASbGncslyT0FqOhSFG0WkY3lSTkKox6ZjIfMwqKDcCA0qbiG0rspxnhpMb/St053N8K
	c5v1wlqybJHgo+EC0s4NjNAUgACDpWPFeRPQqrlqZ8L3EJHZ4JTk8FCeVrmLDCK3fOedidfMTxZ
	dbck8w81jx/68FPzq6aus3pWYiTRDVLyIUTN/L8q44tU/yt85Ad/mqwyMu7DESXvFsZjToPHE9f
	Wu/rRPmcv7wlklmpJTGXMc5ntOBqLKa0PeWNDvqfmTHNZQAY7ZS3ODSN/IGQzzFsuQsP+kqFpjc
	A/LZc7Lf5vfRjZlD2sTsrA==
X-Google-Smtp-Source: AGHT+IG45xtz1HHVnO5crMZXIQ+BrSf+jRQ/5TkER2bq6dQc/Ri7XOY6S0Xc752+lL68GgNCOEr1JA==
X-Received: by 2002:a19:3806:0:b0:545:296e:ac1d with SMTP id 2adb3069b0e04-54838f5b8aamr5129849e87.51.1740481223339;
        Tue, 25 Feb 2025 03:00:23 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514b9886sm143850e87.71.2025.02.25.03.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:00:22 -0800 (PST)
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
Subject: [PATCH v3 2/3] rcu: Update TREE05.boot to test normal synchronize_rcu()
Date: Tue, 25 Feb 2025 12:00:19 +0100
Message-Id: <20250225110020.59221-2-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110020.59221-1-urezki@gmail.com>
References: <20250225110020.59221-1-urezki@gmail.com>
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

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
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

