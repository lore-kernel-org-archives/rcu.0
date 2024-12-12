Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2C223C57;
	Thu, 12 Dec 2024 18:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026539; cv=none; b=RkqD6nOuamTc8UZhb4du6iuIVV62L7MbzNZg4ZUOS7ZCUc6abkktQIAEM/BeD7z4QHJiKnBaojNqBH+ozARWXVGwFrHhg2U1tmMIExyd9eJwWJJNodX//U47g98/kiNh4pH/JDqvtCHPl2JWLzKtiRbBIpf07mgd0SWBlVYBkTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026539; c=relaxed/simple;
	bh=/cyBBJ/kAPT+JtNI0jcacTyHjfq5E8pSjQSNf93f9C4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CY3NfX7YTYZnArAQglJAPjI4KU9BwiKAoaksU6vDStT7EjPlkAJaj85eK752B2k3dbei9D6zMKmonKN/rswZJIWVu5tqNg5WIfHQNh5Tt4fp5fMEDiAyYzoKPhvFziVxYJ5wBpReK6MNNPmK2e97CkMUkU8b32Q728Kyw7hSOMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNs1ReQ+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNs1ReQ+"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5401be44b58so1025944e87.0;
        Thu, 12 Dec 2024 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026536; x=1734631336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdWB7CeZxTt2Nx4wp0TYbeZXKw5F7qc0bJVeZVV8Ytk=;
        b=YNs1ReQ+KCdCi1VYO3YqPTlW9JbevI0bJc4LvPuEgK3DSivX9ApC+E13KRUcYzwiUy
         NbjMymyvNnmi0fBlaKMW7NnJ+CyaAPzYSAgB9DJz9DjS0+DlxRRjBVk/LxDCUaraTw63
         yauBniGxyvsN4u9OarsVjtNGiPioeugMWJFaA9qOvshLbJvIZGlNZkEMyQk7kzXbBO37
         8dx4e4YXqk8EJwrEiCiWIy28aJQSfuy/aNm815zE3gFuugHKYbbBoNzrX8oVGXinqsUt
         mQ8jF8cZyVzeVPHguycrW19TgKerjMul6c/P2vDueDK97s50OWSaahRkGs6SDkaTesMl
         nayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026536; x=1734631336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdWB7CeZxTt2Nx4wp0TYbeZXKw5F7qc0bJVeZVV8Ytk=;
        b=wU//Qqau274MAKQXP2lF2158ozd7v1V+Old42Y/EpCYIOSB0o7u28V7xJC6yBoiT+C
         70pLXZOvVCJowuV3+hBZIIqV3fz2tTks4Krztl1fBYOYcInGH90MAD6W9MNHelKAw2JJ
         lQBAYJoNtYKsXX/VjPUqp5oHmnWesQr6gX+mzWIFB41JeQDTCUmnT/KYQ53cz/zt6evt
         Jo5eZx44O6pZ8h1y9Zb57535Fl62HXuDfhy/AvlWn0Tlzye+a7S1uVftaI9uzi6OKDf/
         z2lxGhXxGk1utVGPwhkZVN9lzWUu5fGuxSTlS4Ink4/GewxYhOOVrONjPyhQcq2BXGN6
         MMTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUywOWFCx9wqCR6FygMw3KfNsot/7t49MhYaciyGzNKQHJK+sQe8SmT256PpTN2BJv3NGp+/djgcml3f5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3VAy0udLmL4CGln1B75NNJCXPn0J2WRiPpBPD8k3yDSTzsoX
	Jr8SKp5DGF/Zow2Ur7Aai/ukgycWpPWTXIPXZQeVtsLCo74Yvna3onf9Bg==
X-Gm-Gg: ASbGncuzf9ZllfztXnODkv4fpols15LIMnWJJ0bH85m9wSxgs5CiVo5cSJq2W9bO8gb
	/W/rRptmLAcLff9EYGMQojV8Tg8vUzYLVsTLyf7Hz0lc9Owj5H8jStL9srerkftJkB7Y3m7nLw3
	/U8sC58uyQD9By0MvED/DD4CXLLlz4nY3PR2dV71w0Pwow9n06mfVLXvNjXJEy0aZjCFjBPdRsn
	RfGPxRdf6MP0sUcwHMQdC/IW112Oo831TiyIUSIT558uov0KKG7
X-Google-Smtp-Source: AGHT+IFL3uXqNVDcCjU+Co56LBNn3KehaHU3DBiOXQtZYB5mPERgTxGbcXsMfrElOzdqOV88rVtyMw==
X-Received: by 2002:a05:6512:3082:b0:540:31e1:c8dd with SMTP id 2adb3069b0e04-54034102576mr544592e87.9.1734026535516;
        Thu, 12 Dec 2024 10:02:15 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:14 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 4/5] rcu/kvfree: Adjust a shrinker name
Date: Thu, 12 Dec 2024 19:02:07 +0100
Message-Id: <20241212180208.274813-5-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241212180208.274813-1-urezki@gmail.com>
References: <20241212180208.274813-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename "rcu-kfree" to "slab-kvfree-rcu" since it goes to the
slab_common.c file soon.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6ab21655c248..b7ec998f360e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -5689,7 +5689,7 @@ void __init kvfree_rcu_init(void)
 		krcp->initialized = true;
 	}
 
-	kfree_rcu_shrinker = shrinker_alloc(0, "rcu-kfree");
+	kfree_rcu_shrinker = shrinker_alloc(0, "slab-kvfree-rcu");
 	if (!kfree_rcu_shrinker) {
 		pr_err("Failed to allocate kfree_rcu() shrinker!\n");
 		return;
-- 
2.39.5

