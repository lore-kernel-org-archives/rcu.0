Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681821F80AE;
	Wed, 13 Nov 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731495616; cv=none; b=tgA9Tt7iZOw3jZUY40KGoLusqsBe43sHvcvZ+2sZXP7r35RIOlKRpv6vf8jKbXCPOt8Ef/qUfmbO7oBmk504OJ+UOXlDobpY7YT536QokTOvBOFmfWlSFC2B2wj/ww5xpzm8KHx1sqWD/g5idki4FKo70sv7Kvc+PW8ENz5PtJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731495616; c=relaxed/simple;
	bh=c7A6ZhNP0ca3q+aD/wxxTUEZQcDKHd9L3m8VSGyzdT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uKoWJ8g3L9W+4Bslb4bFDAg7abFRvbWs5HnP/nm4hQtjHOckgQPdkFoVENDzzrGjTkoYji9l3DVeomL08dvGVdgBQrotoH3qapBsRNA2Q9dWcO4u6D8+qtEHydY+AoN0wqRsuxGt1x/NPTFs2M1jMDIRI1tdFcL/xqK45XQwsNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y73wKtHV; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y73wKtHV"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53da22c5863so375224e87.0;
        Wed, 13 Nov 2024 03:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731495612; x=1732100412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sls+b/kQar7ZAn3MHlwn8LVvLBu2OaXTh16uyd4qyZI=;
        b=Y73wKtHV6A9ByB5bCua0YKcJc7s7pQH6BdqOIU0uLAAsAI6FN/BMaYeFsygfmD8EY6
         kuZySV6Z6wmND2pczVmbBy5jHAxkVi9+ZKJyPs76xxUaOiURFB9FE1VurWpDQtraYkZJ
         7wG5vNWko7l9ClA339ya+Ph05SujvOTUTBVoQGJ1IZchtsHpGw/+WrJPegUw6ifIBfFp
         dWRB3gPPASHrdDzXeoCOme4j9VTdYA9T037I/mdVDi0ySTlt5DN4BTS3tLgodu55Z+R8
         N0zsqwudqlv4eg3iypXE4f6Z7HGVukw0oEe5FiLGl5ILWpHJ059NQwk9G2qI70sgd1w5
         kPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731495612; x=1732100412;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sls+b/kQar7ZAn3MHlwn8LVvLBu2OaXTh16uyd4qyZI=;
        b=sRPlrvn/JUbQ+WfKSs2St0uy71B7TUdI5P4VpLl7TnYdxUw9qWhlA6ITOndcj2eqYs
         sea46G1BeUg3N2srUMeLY04o9sZafY9aQDk7CZwsvst5egeok0RzzW8dKoiCC3GkBaxM
         1ak1fBUnoh7iBJx2zhJDhWOTAgIL0FFLvFiICJKCN0hXwIjnmEorBCubwuzPLyhd90rw
         VRLerj22C1lByZ9bs+m9HL3vrB5NxAiBJLnhyhWBJZ47kEhEzffxRyuMx9izLebET4Qs
         hoOm2RE17+AH2VlrhP6NjyyA8xS8zEmp9pGBEtSXEYCrpkxY4Hm4AhwipmIg/unu14zC
         5Q2A==
X-Forwarded-Encrypted: i=1; AJvYcCV0Wnpn7wWe6fr4UTCf2aLbZBS0z1DGTW7Q4LZgPTtkcFLhkZ0TObsU4FRcZ/0/UqA+xcRW@vger.kernel.org, AJvYcCXchzj9qGRCcRJXz15++ZdKsPUXFkLhRKePi0po/+QTQkXdUtN1hZn+/AKna9K1hZ6HF9OwsKiP8sUg/9U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm1uXd9Hm0fcCPUikMPVGZARCGcjSihjJ0hudw3F/zaU31WjgX
	dQFucVm6U9PegyQCjyPMnew8jTvuudugc3pGyX+VV7sg3Z8CdFlV
X-Google-Smtp-Source: AGHT+IFESrSLq0UKDOKBL3kFiFn+GLnsS6sGyE0j6b4qypp4sUH3K4/WQzpk5+FqWw8tlBcqaL5lDg==
X-Received: by 2002:a05:6512:1291:b0:536:54d6:e6d6 with SMTP id 2adb3069b0e04-53d9a40b70dmr3513235e87.17.1731495611954;
        Wed, 13 Nov 2024 03:00:11 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7287sm2137119e87.164.2024.11.13.03.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 03:00:11 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v2 1/2] rcuscale: Do a proper cleanup if kfree_scale_init() fails
Date: Wed, 13 Nov 2024 12:00:08 +0100
Message-Id: <20241113110009.65256-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A static analyzer for C, Smatch, reports and triggers below
warnings:

   kernel/rcu/rcuscale.c:1215 rcu_scale_init()
   warn: inconsistent returns 'global &fullstop_mutex'.

The checker complains about, we do not unlock the "fullstop_mutex"
mutex, in case of hitting below error path:

<snip>
...
    if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
        pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
        WARN_ON_ONCE(1);
        return -1;
        ^^^^^^^^^^
...
<snip>

it happens because "-1" is returned right away instead of
doing a proper unwinding.

Fix it by jumping to "unwind" label instead of returning -1.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/rcu/ZxfTrHuEGtgnOYWp@pc636/T/
Fixes: 084e04fff160 ("rcuscale: Add laziness and kfree tests")
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/rcuscale.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 6d37596deb1f..d360fa44b234 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -890,13 +890,15 @@ kfree_scale_init(void)
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start < 2 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are not being lazy as expected!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			firsterr = -1;
+			goto unwind;
 		}
 
 		if (WARN_ON_ONCE(jiffies_at_lazy_cb - jif_start > 3 * HZ)) {
 			pr_alert("ERROR: call_rcu() CBs are being too lazy!\n");
 			WARN_ON_ONCE(1);
-			return -1;
+			firsterr = -1;
+			goto unwind;
 		}
 	}
 
-- 
2.39.5

