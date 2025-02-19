Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EE1E0DD0
	for <rcu@vger.kernel.org>; Wed, 19 Feb 2025 12:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969673; cv=none; b=l86Nh7Mwew2mMrM1wbTiZDSvGQ6iV/fKhva1QxNLwQS6rtaj1+Cr2YwkFkcBTDt9rqlD2ytZRz11nt3eOImscJAwIDptA9WBSEvUJle/KekZQ4OtnlCX7tdUvu2UZV2u9yx0mRTxanyTBBEN/km71Kwpde+GNqS866W9qr6o3fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969673; c=relaxed/simple;
	bh=ZbFDSDP6ihWQxeV8n2QAe0hnzHYjfxm2Xc2zWrP5Ae8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rtSLEAJoyfsAlrhd4WIMXBqdJTCgG6O+UHQu96f2Wb9WlP07DZMg8KfoIiwZNefCKT9yS3VnrB2MkcFZw9ztbcijDxOVWxvAxVkm3Kd9m0Etp5eeBxmc8lQh1uIlPmyQ5Ui9BJMjXX63b3XmNO+ob1CpjIPMkVcMJXOlR05R0A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=kAQ54mvk; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="kAQ54mvk"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c0893f9aa6so388966685a.1
        for <rcu@vger.kernel.org>; Wed, 19 Feb 2025 04:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1739969671; x=1740574471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PGyRcAMv6rGFWkpbew/x+SUNeZB9997kAxXImq7GFIY=;
        b=kAQ54mvk3YV7wh4UWK++qymxn6HFWzW4rfe5GAIH8dybDntTfGbouiEjR1JQYD8MVi
         Cnbtm2JfIXvTuyREGk3NZCL7s491+PMevPctSbeNU7BMwYpqTIZ/RqMYtGhaDivxUGCY
         Eaf8oJ7TGJRo4ZlYT1zUHb2VvnRVr61XJJkHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969671; x=1740574471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PGyRcAMv6rGFWkpbew/x+SUNeZB9997kAxXImq7GFIY=;
        b=vedU+4g78x4UQ+oox9ujiuXngOW++qFM47swCcOei96rP5Ztl6NrHvO8BgVOWckXH0
         PsDC6EbFnmnbzFrVhPsmKkBMvPFg01YoNEEDA0gVUVmYKuvAGWSGRMSXaGFTv4DJuLOn
         scJjPG/gBt8v3/uHwAgKxQ7lOiLr0Hd+40TbIAwZ/i8LNZzLgDa4oeCJL2g2WWRpT3Go
         WxPzzw+JtJ0D5y23ubUUHODVW/tAwBY5npwdqBHu2a+bxRGKLHZCRqogtVZsxslEA5jF
         nbbK8MlWeq8xtODhllLzW9Y1huWU0PuwZxyXBFere6ywN/sGKjNVpHwm78ve1sJ5iX+U
         bq9g==
X-Gm-Message-State: AOJu0YyWVxgSbdWyCIPnuagS8yRzQhBdgfXI2Ch2V08FAdXUaeV5mFUQ
	aRDaLW81TW0lV9RRuPJWFhFny408cgey14IPtXlIS+sWUeRz5aS5iFggXGIcZRgmsftZeM9B9yh
	c
X-Gm-Gg: ASbGncueJDkYLgZVIhBpSq8QuvFpJgrdNCh1jq1BGX18EJHh/RFyiNP3k6OclWdsfNK
	fPGGEnHXJWJoVZ9xU1vYws4P6qRZIR+sNOu4f0eoJMv3tMD6jKPXvW93iSk/GCDdAEnrSyYVKKO
	ZsrQCw0d/j57fAkZcc7fdOQVUqv4EoSQ+V1YMz7+dCmxq9BwKjalkbrKM1Jt+8DgdO3TQK7nVZg
	a/Y22hfumN4UUih9UhvodmlzFmllKaKCn2AWLmE3YdmZDvnSNCM4nY2D/+aWeoBB6ps4kCeTaqD
	rfsUOLLGxcZAXam0w3marJv9ZSgb1D6C/irW8ewfbfzwckAg+NyxJvaK
X-Google-Smtp-Source: AGHT+IGSDagjmy0sJ8WQxqSlY0UadiPBt+TBfV2Z1f8LHGSNN5HZAWiTioBZhRnXhlGmK48JoOI1fQ==
X-Received: by 2002:a05:620a:288b:b0:7c0:7a41:667e with SMTP id af79cd13be357-7c08aaa8aabmr2374004585a.44.1739969670662;
        Wed, 19 Feb 2025 04:54:30 -0800 (PST)
Received: from joelbox2.. (c-73-251-172-144.hsd1.va.comcast.net. [73.251.172.144])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d7a436esm74469496d6.62.2025.02.19.04.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 04:54:30 -0800 (PST)
From: Joel Fernandes <joel@joelfernandes.org>
X-Google-Original-From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	boqun.feng@gmail.com
Cc: rcu@vger.kernel.org,
	Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH] MAINTAINERS: Update Joel's email address
Date: Wed, 19 Feb 2025 07:54:24 -0500
Message-Id: <20250219125425.1175676-1-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update MAINTAINERS file to reflect changes to Joel's email address for
upstream work.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ff7ba6cc270..97aba6b60158 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1608,7 +1608,7 @@ M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 M:	Arve Hjønnevåg <arve@android.com>
 M:	Todd Kjos <tkjos@android.com>
 M:	Martijn Coenen <maco@android.com>
-M:	Joel Fernandes <joel@joelfernandes.org>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Christian Brauner <christian@brauner.io>
 M:	Carlos Llamas <cmllamas@google.com>
 M:	Suren Baghdasaryan <surenb@google.com>
@@ -13296,7 +13296,7 @@ M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 R:	Akira Yokosawa <akiyks@gmail.com>
 R:	Daniel Lustig <dlustig@nvidia.com>
-R:	Joel Fernandes <joel@joelfernandes.org>
+R:	Joel Fernandes <joelagnelf@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arch@vger.kernel.org
 L:	lkmm@lists.linux.dev
@@ -19671,7 +19671,7 @@ READ-COPY UPDATE (RCU)
 M:	"Paul E. McKenney" <paulmck@kernel.org>
 M:	Frederic Weisbecker <frederic@kernel.org> (kernel/rcu/tree_nocb.h)
 M:	Neeraj Upadhyay <neeraj.upadhyay@kernel.org> (kernel/rcu/tasks.h)
-M:	Joel Fernandes <joel@joelfernandes.org>
+M:	Joel Fernandes <joelagnelf@nvidia.com>
 M:	Josh Triplett <josh@joshtriplett.org>
 M:	Boqun Feng <boqun.feng@gmail.com>
 M:	Uladzislau Rezki <urezki@gmail.com>
-- 
2.34.1

