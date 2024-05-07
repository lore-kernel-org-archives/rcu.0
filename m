Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D956215E1E5;
	Tue,  7 May 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074556; cv=none; b=nVn11yL4sMRfK6uC/COz1SLknkI3rXb2ffkF1wdJxiAu1hPUjWJZ6efdtv7WhsJK69wdDtI2no4HrLpI6gudn1aAHuYXByIPjVR9VDtxsZ7Ru/Sb4oP51zXcVk9FUsdrDyNTrsHc/tUL1qewe8o5siaHiVOnLmjwETjFjezSkZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074556; c=relaxed/simple;
	bh=zfE0jzpc3gN4d7Fx9F2XDO5M9JRfm30TahjMHP8f+8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=utBuqLiaXi3dFEACZfs5us/sMjeGcLN8jf7FZqx3FM/dppwaeKB3dtZszYtr2UXFeFkRX7czymW2T2g5bFMcq/qXMPcRnq03+0u+Lh34YpChv4JYTRz3f6mFE5TLq+NY373U9WN2jkUCf6xRnVwJSqiJ1VnNzaC4jWD0SFR29bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQla54pN; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQla54pN"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e1d6166521so42221031fa.1;
        Tue, 07 May 2024 02:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074553; x=1715679353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAJsYakYPuzaiyx0tsxsRzlSG1LGaCLezN9z7sN3Trk=;
        b=bQla54pNU/AWLRtf8gB4cUHCrmGsOZ9S1O/TUwWSSEv4NDyGqsVEK6tvZxViqQQKz+
         2Un2jv4lB3zThS4ccNtPXIY6d8XmYz7ot9D+4/3q/KA1WsjoPHQMaRcb8ZFYaH/3Swy4
         CSKnNP85PT03OTLt/X33KpMCpLmTjZzA7twWSydtXWjSy/tjN09/cqdx9i3OAHf4P6Sa
         WggZlClAQPDMnMI/vDbpjk4IXOa8GbcIMYd/ZlxrVTjo+7tiTsZPuIosRz93i6dktMpI
         ubsyHb9PzDGbiRVrECjOP8kqvv5nwSEV+wdbAgXQbC5OK0ok/MtpTVBcrNH1905rZMDx
         Cbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074553; x=1715679353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VAJsYakYPuzaiyx0tsxsRzlSG1LGaCLezN9z7sN3Trk=;
        b=b7C1fHTPnmNrLQ5KieZ1ewjsIgVQsLpvfRFmx7mRbE9cAEW7gR9B8W+VuggWQXkHKb
         DbOMgCaM5zgjdRfmmYYgQefecUDLkeB67/NnxLGbzFgOOJjKA0+NvTdlTPDrGmSzkscT
         f9mYgQXM/yIwfJfsVLl+KuN3Eh5oVNRcmQQevCQw1a58T7XL8Cl/SW/Hyp82a9l3+kxR
         YZTrNx1bRaAbjOQ9EXseXp+I9g1zh/LDeILds06it32xjy9MBdB0GNquFCAvznzGoYcx
         pTFjpcMipTr3t1ZDKYHdN66p6Lk+8zXQCtgD7BWwFBUxYn4ApCNVa7LkD243Evew7nRk
         hH5w==
X-Forwarded-Encrypted: i=1; AJvYcCXlEA4BKO3RvM+j4VRnoBv07iaP/axORqco0KIMopcJpixhtrlOUn/2KLvlmHL/oIvd74tXflM0m5scHuju6jD/PFq+ARD7rrfvSHhL
X-Gm-Message-State: AOJu0YxZ3+SO5yfMhXEPIc3w19LZweCQWismQPIiFUuxxJHo8q/+5iVg
	ta+WepJXxD1U84iTKeGG+znKmL7DybIzM6hQagluOnjdiv50mSWkBL8bLbmn
X-Google-Smtp-Source: AGHT+IFHkxQwlfbiNpBbu7tJ+xnduiAQ17o62nmnxK29X7BBRylBpjE6EC6cV1+IWSFFcZIOYcYNkQ==
X-Received: by 2002:a2e:99d7:0:b0:2df:4bad:cb68 with SMTP id l23-20020a2e99d7000000b002df4badcb68mr709364ljj.16.1715074553013;
        Tue, 07 May 2024 02:35:53 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:52 -0700 (PDT)
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
Subject: [PATCH 21/48] rcu: Remove redundant BH disabling in TINY_RCU
Date: Tue,  7 May 2024 11:35:03 +0200
Message-Id: <20240507093530.3043-22-urezki@gmail.com>
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

The TINY_RCU rcu_process_callbacks() function is only ever invoked from
a softirq handler, which means that BH is already disabled.  This commit
therefore removes the redundant local_bh_disable() and local_bh_ennable()
from this function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tiny.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 705c0d16850a..4470af926a34 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -130,9 +130,7 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 		next = list->next;
 		prefetch(next);
 		debug_rcu_head_unqueue(list);
-		local_bh_disable();
 		rcu_reclaim_tiny(list);
-		local_bh_enable();
 		list = next;
 	}
 }
-- 
2.39.2

