Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B07515250D;
	Tue,  7 May 2024 09:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074544; cv=none; b=XXicRjmZizo+aaniwKCnyXqFarkSwXEXuod4E0BYwRnRSR3TyWsYlT/iO0iWKI3SPi1mjmf/d2mcrXCEHbQEFVE4A8x+scLeZi+gCa0LRL0y+ANkXLsa9UxtdK6XqlaP/fTjmefYhC09wESKFIz6ERMm68L2Wuyg/ose13feNOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074544; c=relaxed/simple;
	bh=Ul60Dz2Wb7t1suuj5txMkvljL21mKCYQ9LzjJSAVCpk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XzvjvHKPpLa3esyowit5Uq8ILzJ6axFAXoIOps173qSqKxV4ptjTH2IVDxfYFKmEMGdgyLeTu2ULl5siKc2GqsG38TuzQpcHBvzfJnRpTuu+BjXGGnZ47J6Ko5iXhk7QWkHri1x2udKbTySfwOrgJtgLXbFeCut5BbU7vcGsiWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iK2Hot4e; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iK2Hot4e"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e34e85ebf4so16678791fa.2;
        Tue, 07 May 2024 02:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074541; x=1715679341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ODfneSlJwi5tq6mU5vRRHw3ltc4HQQLLdkqm9V0KGc=;
        b=iK2Hot4e0cONi1/SDuL1u5yYoJa9G3HunmWZldrdXZ6qmAMOO25TkFMN6EXZjUkkBZ
         wMSOm1yza8kSGEAfV0AGg+E6Wg+OtsRclXoDWAryUizo8pc0AGEcICFCRscjNKsj2zjo
         xYX9UJhU/nrNX1Obcy1k9Mr31ePp7u8RsmtcRv003dXdEePO/kGd57rdTiNqOzec8TDF
         w6BS884E0jz1u3o8WIkZbCuAobZJscI0LjfkMDngEMAg1PeRaMlcMOrWbzBqUBSUJWfh
         +K1TNWhpLnJwbZHq3IavtUtodYozgdoD0ylc5vl2yuSgV8JF4yvJ/ItuBOeCaKNDPJAC
         wV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074541; x=1715679341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ODfneSlJwi5tq6mU5vRRHw3ltc4HQQLLdkqm9V0KGc=;
        b=k0T6zUqTC94mZyTblolMWnnoKyVC17nyKh8HuNlBF/woiMq2Yt3uxNq08RufRPOlUz
         aAH28ExgiPwBfLU3S02biAXsrdKHXpEV/vduJkZIpjLQuLzHjJJZmjKQQ4rK3OZBpO9a
         wILRMyslbhya8/gLxfpYXU0W0a4dKOOA4v25OrPguLdDqZuU2BnOv3hg7qwVf2S3b4SG
         NnsPn6++fRM3n1ooRBjH3uaduMJJ9m710Evc9i3vgmjvr5n6b3o9o0CeOhsNnYIAN2Lg
         nz47EgPa9EqFoPY0XEuY/prOq1+jadrc4UsNry9oV6Wf+W8PDi+bfEbEsoQ+F1TvQxpy
         AY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFpP4tDWoHZ7mvpdGqp4is+8L2rpZZXfPxSAaKv5KxZc5AMyutUFWIaAJyVRPUV2evqaIJHGrfvM2N3H3RxlPjmwzKb4t8gwFiLry0
X-Gm-Message-State: AOJu0YyMgXyruHaLbPtqiFRsb2edTj/fSVbo5WdgxtTI1NrJEPaVAFdd
	mDIt6GuqCzfGPqfr7d8plKbALR8V8nnb4ApP5OfUyIydeDA5pkmp
X-Google-Smtp-Source: AGHT+IEhy9I6zK1bKc7Zlag8/vshhJpg+y7oa7zLYZLeeXFG9gFd1GEJa1QUDul2IKsFXRXWBZB0Jg==
X-Received: by 2002:a2e:94d6:0:b0:2e0:37be:b70f with SMTP id r22-20020a2e94d6000000b002e037beb70fmr7454523ljh.26.1715074541347;
        Tue, 07 May 2024 02:35:41 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:41 -0700 (PDT)
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
	Frederic Weisbecker <frederic@kernel.org>,
	Zenghui Yu <zenghui.yu@linux.dev>
Subject: [PATCH 09/48] doc: Remove references to arrayRCU.rst
Date: Tue,  7 May 2024 11:34:51 +0200
Message-Id: <20240507093530.3043-10-urezki@gmail.com>
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

From: Zenghui Yu <zenghui.yu@linux.dev>

arrayRCU.rst has been removed since commit ef2555cf68c3 ("doc: Remove
arrayRCU.rst") but is still referenced by whatisRCU.rst. Update it to
reflect the current state of the documentation.

Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 Documentation/RCU/whatisRCU.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/whatisRCU.rst b/Documentation/RCU/whatisRCU.rst
index 872ac665223f..94838c65c7d9 100644
--- a/Documentation/RCU/whatisRCU.rst
+++ b/Documentation/RCU/whatisRCU.rst
@@ -427,7 +427,7 @@ their assorted primitives.
 
 This section shows a simple use of the core RCU API to protect a
 global pointer to a dynamically allocated structure.  More-typical
-uses of RCU may be found in listRCU.rst, arrayRCU.rst, and NMI-RCU.rst.
+uses of RCU may be found in listRCU.rst and NMI-RCU.rst.
 ::
 
 	struct foo {
@@ -510,8 +510,8 @@ So, to sum up:
 	data item.
 
 See checklist.rst for additional rules to follow when using RCU.
-And again, more-typical uses of RCU may be found in listRCU.rst,
-arrayRCU.rst, and NMI-RCU.rst.
+And again, more-typical uses of RCU may be found in listRCU.rst
+and NMI-RCU.rst.
 
 .. _4_whatisRCU:
 
-- 
2.39.2

