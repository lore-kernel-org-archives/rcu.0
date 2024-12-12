Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BAF208992;
	Thu, 12 Dec 2024 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026534; cv=none; b=hLzJiwrfnYDxcZshZUoDUGPgmh+wN6InSvZzBnPLnvmfSIEgs/4K3UmFkoUKLjMyvZAE2EYkXJrtlG2YR+e2U8RtXj90E36upLF8fLwzL0dnHpdxRz8waoRc2bOczvDRb8k+ELLgywK5e61TKv0ZXRHEeBLJrzC5BXTpjMs+NwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026534; c=relaxed/simple;
	bh=RhuTGOdexWC0/SKmjTRi0MeNBxqfBL60KGa8EQ5PKJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D2Xl1A3klDihpjdpOLurIxeoPZkJ3xlD4ZoVb+rIwnmVDMUsfIYGJqkBbXWU4+ZY+w/Rja25wMo6+J6UyTuX1/r1ZHPutplz0UNC61O+CQEhFf7WZ+wQnTCBhTPLsqXQ9HSWeo37QkBdKTExeHmYwlC/c5D5v//fSh0OUwTAivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtUM7ZMW; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtUM7ZMW"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401c52000dso1006098e87.3;
        Thu, 12 Dec 2024 10:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734026531; x=1734631331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Yyar+/UK3UHu7jv9j5MYFotaTyk05/FsbHDmLCXdNs=;
        b=VtUM7ZMWEv1FU9jrYd4isWubfEZPKwWXjrU/abFRTAYRoimhRaZcKTiwH1WMbGjnVf
         KmBREtitIOjc26kHwv1Rk+JOpS6n9sBTfhRc7dvxuPcQucN3lTqnylfR9HI8rsLVpepe
         ixaEy8BBHqrZ5Npa6oYGEeSDsdR8TSQyXiEPogwELSH63LpB0M7XwOJFs79rDk19upNh
         jqUBkhIMlORpNfVpRbaBfgrRjBmH4He3bFi05ld2idY1DSkQqqSlSwQRWTsaF2R2jXAK
         WkOWDA/tyRBipNZNYMloFVNLRjdD+ax13og2r+GtUhOuccbW1OcC09gfhPrVSjogkEix
         p78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734026531; x=1734631331;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Yyar+/UK3UHu7jv9j5MYFotaTyk05/FsbHDmLCXdNs=;
        b=UhhybgpMfQyPbPx126VHR6mrfQJOc6/pbm0uHC4ZIgHCOj6CRJXlsrLH+iDSwdiwwB
         w3QuY9iZXNOOGJrN3pvQUPGpo5XuXXqMLIM/bjVHVnAAHRbTVyWg9wyvQ+YuvkY2G+iO
         4NddU8Q6lvl4JnQ4o2QnTdb/zEzFM+10OnYBdWG//pgEmePnQ6vHfRPjY/x1C+s17EoS
         uJ85laq8k8Jep46bPczViDAg40K4f89irxdVcg/aOZz9zakq76yr2g3oe4M30+lOOgTK
         5fin9BO981ilT533v/gIAH0KRF2+9tb9pu9qgeO36mcns50VxH/f8QVCQp+qdRaWKXen
         CPnA==
X-Forwarded-Encrypted: i=1; AJvYcCWfn4styMdo0ZhTIcoAv5nynjEi8YelEtznkXK70kfXQxrWmhDS9MGJRdFJcYbyUcv7iVMSm4PoRSNuXS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSBY+9o4VVmUSZUMPWttIN5qTliJiwHrbWSuU/S/dZjHxbs4yg
	4EtjWDQHq0nIMVERTDXzptemdbIuTchw/m7tl4/MaFfQmXZoAthw
X-Gm-Gg: ASbGnctp3205B4inBhf2qzlo7peus3dXb2bbQAZ20Hsgo5QhGP0qqlkZQKcogriKmgF
	bHdZHobSIlv4FIK0zyNN7XgP/PIOFcgmyHYEAvuw4J1CBVIe+NPkbRhTTbW9WBXFcjyBrl9r6GK
	MqOHxaWC3Zx5iZsNBlwj2HeD/O/Kb3Fdqc3cyumRjWzZ3pv7GvHrYik7+764zRRbRa5XBKV/Bol
	4sc/mR3Im/3QGqcpEhUKwXX884sW0srTW3T2lbKFFGvK+iQ0mRe
X-Google-Smtp-Source: AGHT+IFEuLOgv75c7u4xf6kwYM0OxGq31VqT+OtC2H1NfblZU+Bx/qpixIlq2KU38m/OTDQ6fi4mrw==
X-Received: by 2002:a05:6512:31d3:b0:540:30df:b3f1 with SMTP id 2adb3069b0e04-54034106e98mr638959e87.17.1734026530909;
        Thu, 12 Dec 2024 10:02:10 -0800 (PST)
Received: from pc638.lan ([2001:9b1:d5a0:a500:2d8:61ff:fec9:d743])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e39375d36sm1940645e87.7.2024.12.12.10.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 10:02:10 -0800 (PST)
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
Subject: [PATCH v2 0/5] Move kvfree_rcu() into SLAB (v2)
Date: Thu, 12 Dec 2024 19:02:03 +0100
Message-Id: <20241212180208.274813-1-urezki@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello!

This is v2. It is based on the Linux 6.13-rc2. The first version is
here:

https://lore.kernel.org/linux-mm/20241210164035.3391747-4-urezki@gmail.com/T/

The difference between v1 and v2 is that, the preparation process is
done in original place instead and after that there is one final move.

Uladzislau Rezki (Sony) (5):
  rcu/kvfree: Initialize kvfree_rcu() separately
  rcu/kvfree: Move some functions under CONFIG_TINY_RCU
  rcu/kvfree: Adjust names passed into trace functions
  rcu/kvfree: Adjust a shrinker name
  mm/slab: Move kvfree_rcu() into SLAB

 include/linux/slab.h |   1 +
 init/main.c          |   1 +
 kernel/rcu/tree.c    | 876 ------------------------------------------
 mm/slab_common.c     | 880 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 882 insertions(+), 876 deletions(-)

-- 
2.39.5

