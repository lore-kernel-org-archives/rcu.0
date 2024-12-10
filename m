Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BFC1A3BA1;
	Tue, 10 Dec 2024 16:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848841; cv=none; b=TWTLBIPZRtKKF0RGyEwjOAEBtwuXS5xOD0hzhaRKg4p2l1jn+ZGgGk0poeap5+Ixa/s19M8x43G4924fWI7rSJ/bj7j/OQGW/+V/h1m35ZsPyaTwz9KiQopD2247RmAvGeTV2jNY5inMvOUacncnQPMows831aj7tK0II4o+3NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848841; c=relaxed/simple;
	bh=M4ooYKAP68HiocUG6DLFW5qEwy8s/XFVd985iW8wS6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RRY/dLvNF/YYFrZvmBqir7BkPvb9NrzVWXY2rpKV1FZUysEIeEljq0ZGKuWAhLhpE3XeP9YImaoW/hYshpVRZ70LtqoEj3sZzFJoZgAaqKGGWnykyaglmeFefK29vxpXzgImLi1aJ9pR6ckBiKVnFDvuEaFQTqtTgMhhi2NFWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H3+duxsp; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3+duxsp"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-540218726d5so1912251e87.2;
        Tue, 10 Dec 2024 08:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733848838; x=1734453638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l1NR4XDrzkG0LF9IjqYUSN1Pt/c9p5VT4+mElCy3nh4=;
        b=H3+duxsp473n8IPiTQhyR853UuBvplh7MzLilbkbPEEwUpwZP/lSVFA6XgHePp/4If
         2X4D+Y7S0Dj9ioLl8Ppoi11JrVU0L20iuu1MpQiJsZDBshH+wiyoayFyF8BEqzEzYUUp
         T72hyLB0xpkBVvoTo1wAhTd3qfo8GXNhSjLsqyxW82mfGe8+UqHoN5v7sSrF9tALlkuy
         SkmHS9Pb8kFCn/uuy8xTuonQEyqLhmmvst2oD79Mo1g4oHkUgm9/RXGH3wIxawFfNld8
         0pXK1nplRVS8GkqN5NDhm9Ph9sg/UYrcKaGy8MSD+eKZPFBRe599DZKM9tIFxMZ2Zw9J
         3CGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848838; x=1734453638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1NR4XDrzkG0LF9IjqYUSN1Pt/c9p5VT4+mElCy3nh4=;
        b=BJRkI0VhQrUB+Nu27Roj5TkwIqYSyaywddovyOZk041FxZ+zFOz1sjE9xNLXF1u70L
         QTjeZlrXOk15boWWS2oyY0EhqYfd+wTJsrb0BnuEtaepDeivaqX4E7weab/i1LNgpRT2
         pCG0fI/EbGQECMRGXztJuyuBv3yZJtaGi5ur/gtyBlcX+Nthz4eDBQF20pf+xmm2nzlz
         RiBNeuK/iqN3COT96v2pR2uhV2ToF6beOA9vPWjKX8JDWPog90AvhMi7DA8NYaSlJ6kw
         uYeYEOC0gScqKl9RuLzo4Mwpl96cqYX78ICHqApxJPm9dlDQyznXSxMhDDNEyvXZd0wd
         o9BA==
X-Forwarded-Encrypted: i=1; AJvYcCUcuDHr2+/zFBw3D2y3mWt/zzVR5qGJzQWmopYpadCIdhBvJKGVGVZdDuXFv4KNwUewmY9BHUe+EhS+2i4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysLn113RHcH+eVbNUKHNMJbUa4o6jIMPsbk0v1oTWFPjUFgcGH
	LnQT9NZMS3Z6WTYN1gw33e/+tH9aUEWMtZ1DpYBJ9yfP35jezmpQ
X-Gm-Gg: ASbGncvGVgYz/DbTKXeSG3hvziIvuXkT2LRTOkne+s9SZ3J1gRW+skbaRIhuzURrBCJ
	V2jHPWmtMDN+dGgjy9rKZoiDk0LxDlCGcYrM/h6NL1cLixVidyGynVrVYXIIv3Txk9mQN8rqIaH
	L2Idmb0A2dVJY/RQCpprTJCtONZtC9s65J3CM1likF2AMRb48ZY7cSGw+/YbReYVVCdwirAMMJK
	0F1prvIC13gcKfH4WlE9txtpCM95rtKiyVqq+OiAHjOmI1n4g==
X-Google-Smtp-Source: AGHT+IH9RyvPRa6gS0q+nSyvQmhCivmoPKywFQXKBsBvN/j3adpTWSGWBc9DS9ApCiXsjFLoA/AoAA==
X-Received: by 2002:a05:6512:6c5:b0:53e:350a:72a6 with SMTP id 2adb3069b0e04-5402410fed3mr1519426e87.53.1733848837503;
        Tue, 10 Dec 2024 08:40:37 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f93377eefsm1031875e87.67.2024.12.10.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:40:36 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>
Cc: RCU <rcu@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [RFC v1 0/5] Move kvfree_rcu() into SLAB
Date: Tue, 10 Dec 2024 17:40:30 +0100
Message-Id: <20241210164035.3391747-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This series is based on v6.12 kernel. It is an attempt to move the kvfree_rcu()
into MM from the kernel/rcu/ place. I split the series into a few patches so it
is easier to follow a migration process.

As a result of this series, the main functionality is located under MM.

Uladzislau Rezki (Sony) (5):
  rcu/kvfree: Temporary reclaim over call_rcu()
  mm/slab: Copy main data structures of kvfree_rcu()
  mm/slab: Copy internal functions of kvfree_rcu()
  mm/slab: Copy a function of kvfree_rcu() initialization
  mm/slab: Move kvfree_rcu() into SLAB

 include/linux/slab.h |   1 +
 init/main.c          |   1 +
 kernel/rcu/tree.c    | 866 ------------------------------------------
 mm/slab_common.c     | 875 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 877 insertions(+), 866 deletions(-)

-- 
2.39.5


