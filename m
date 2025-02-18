Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE98E1B87FB;
	Tue, 18 Feb 2025 05:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739857557; cv=none; b=jaGaf47SwtBx8i0NODPqzXUElrAA2SPsUQGCLuV83GAefmVSGLRFIokkuxad8BggvgqkNcdQF++QN04RH854zmhNVf21vEapqpsBHB9BtH9HWrLcUQEDBRn4a75xmsUtzEiZBNcd4j7ra6znm7rJ8ZkARQc3oo2/uH/rpLFulXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739857557; c=relaxed/simple;
	bh=ALADyHX5VhAV02ZKuvBN7XXssxlDHMGJm6kTwpqvGQg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WxSt7/tPRw5S5ms7aRbEvWbRheRnRICMPd0BK+JI6ej3RBGDg8nYBv5mOWtu/ESy2extmiM6VCb/aZnu1txmUay2DJo/369UhPAcKVdtiloIP6yjKbfOivNz8roCA+yO8R+gSIN6/pwNO1oXW95Joi5y6fmouUtznHUxpX/pCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su1kuM18; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su1kuM18"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c09d7bb33bso151530685a.1;
        Mon, 17 Feb 2025 21:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739857555; x=1740462355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wjntYJCIcfuD8CldiVvqZE1cSqLv5zhXph107GuOJoA=;
        b=Su1kuM18yPTqMtYI+WmnK3JdR+mhtEAaewCfGME1nvgiXyUsB272qTC0GJLuua7za5
         6d0j8rndI2iqzq9kSvF7n55JRmN+R2ZCBcGGW2CD9l1do8FeOLdF/U+59Qa83kTgc7uM
         2kmA4+WPrBlyCYYtbazgKKbAk7y3dSo2kk+ouJlO/mXtmyzn20bAnI6hPGhVe60CO4pZ
         dFwM50DS+E6EEYCikgP3ffcZum3bjo9APYR5RyP9wix8WSITZcXOp3xNvZ0+gPu0av70
         CbGNpA5DC/YkEgZ085HxdSbVuQuNqDS8bvKEj2LJkjLt/CW4A9RwQ7NQIQzijrWLJeKE
         Rs7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739857555; x=1740462355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:feedback-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjntYJCIcfuD8CldiVvqZE1cSqLv5zhXph107GuOJoA=;
        b=eECBR8ZUP7m6wjLswAkmw8DwdLxlBUQs760tuQJE0Ha5aoN6eCcCeINCAzP7rrd6VB
         HUuUyqQi1eNk80ver0Wctp/hHoBypYbB1E9SyJaxfTFwNb59uUSudPU72lneaulL5q5i
         /1zHI17NAC68up3seK2ZBPm1WJCaqLLPRcy2DcM4er7pNK888apN+jTg7RdZ4w5aJ4mw
         qI6jqRCZMLM2++5zO54dL94tC5iptJ8BeJzYDiOX8p63SPAinsnaOMGJMQBvk5mbQQzY
         ULAEuF603p/BUYo4/1L38fhv8LRhbbXFWhljMJNFLXy3Tisi6spfUDgvWBIJpKdOc17s
         ZG+g==
X-Forwarded-Encrypted: i=1; AJvYcCU5Dby2dE1aHrx7f7MT+TAroxeRXkwk9Enj47gmkSdLEo4PuvrdOgSPdvPr8kasRpTc/NFsyC1XXVC0enQy@vger.kernel.org, AJvYcCUUf70MaPqTxePABCaLaxmc8FHC3K7j8FkuA3FREj9QG3SfVSuujPopQ6yhJUuFhyltee2YeBI+OUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+tKPE1qExgLux7ymksBY3u6CSSs64H7Zp/OUUl18FeZ7p88W
	UuylcNInPTY70f+RxxuqM0bLmuSYz4Jv8kHifrDwISOW3cvhpxxp
X-Gm-Gg: ASbGnctPuT8DLeKlaSnEpHUscKNkignHR/HVrirzz22Zt86MSjiX9Bc/5/BIGdAVoIu
	XdX5wcBcvgVKBSaPXqPACfprJUq/sGChrRclmvgEQoQPEM0CxPrFHe7VV4DS2Vaoien7SgGNiMZ
	bTUexX5HdT+S952P1rYdFG7BFBGCdQLVQWisrcPfvs3gH2reV/t5xz6K1BrCiH09YP/Shu8KTAO
	KE0rkRC/FE0o1x4cRM8pNeyovaDe68chExRb7QPPmFZQhIw3R9mFudfzQiZQQhtx8ZKqjFhfgvU
	rXHW7KuBJpr5EALp5xB5oxi/pkgWUnOxp0X7o91YcUu9Uaa6BfG/rcbR+hkuAS6BkRne5BVVQCc
	mHJeD6A==
X-Google-Smtp-Source: AGHT+IG/SpX3zB0HimK0pVkXAyNU2kXrCbJzwn+N8oY+CNP5mb/YhzJQGmWgJ19Vwa1VFKfuvtQaCQ==
X-Received: by 2002:a05:620a:4506:b0:7c0:7935:63f9 with SMTP id af79cd13be357-7c08a99ab75mr1426417485a.3.1739857554720;
        Mon, 17 Feb 2025 21:45:54 -0800 (PST)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0a62e9865sm119817685a.59.2025.02.17.21.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:45:54 -0800 (PST)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EA541200043;
	Tue, 18 Feb 2025 00:45:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Tue, 18 Feb 2025 00:45:53 -0500
X-ME-Sender: <xms:kR60Z8yOr3qb-vK9D9yCXGBZ6G64J4KciVrzWNYRqZM0u-DLTIuBcA>
    <xme:kR60ZwQxEcsa6Fop05D_KIq7I71Jq5J289DGeizXbv43Zm5CZZCT0M7mjbxZ8JuiM
    3yy29HY6jmeNSUFoQ>
X-ME-Received: <xmr:kR60Z-XOa4fHzyHs911Z7i5Toyd2-Ix2TQ_JC4Ti5WLXSRn0nLZDaK-4Ww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtg
    homheqnecuggftrfgrthhtvghrnhepgeegueekgefhvedukedtveejhefhkeffveeufedu
    iedvleetledtkeehjefgieevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepudehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohgvlhesjhhovghlfhgvrhhnrghnuggvshdrohhrghdprhgtph
    htthhopehjohhshhesjhhoshhhthhrihhplhgvthhtrdhorhhgpdhrtghpthhtohepsgho
    qhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhrvgiikhhisehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrgh
X-ME-Proxy: <xmx:kR60Z6hByBo7MdF4BhLIMsnMdNTRbnSGoVKII_7leBpLJ9hY5iPmOw>
    <xmx:kR60Z-CoZMVG1h1oin7xsrOtJI14tD_m26KCLDQVZ_zpaCheBZ1--w>
    <xmx:kR60Z7LD--q_GMQX84O6Lrngunl4zWM79dYBBqXN2LxsqwhgP__6JA>
    <xmx:kR60Z1DQuXWPXJEUwlRxznMS6ImkfuVuPKWYjlxQlR-BSPMvjwLpcA>
    <xmx:kR60Z-xetoOVGt95xfpZpV6EH35dpolRm9DXt9PIGb2nez-J5AYHfkfs>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 00:45:53 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH rcu 0/7] RCU documentation changes for v6.15
Date: Mon, 17 Feb 2025 21:45:40 -0800
Message-Id: <20250218054547.7364-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please find the upcoming changes in RCU documentation for v6.15. The
changes can also be found at:

	git://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git docs.2025.02.04a	

Regards,
Boqun

Paul E. McKenney (7):
  doc: Add broken-timing possibility to stallwarn.rst
  docs: Improve discussion of this_cpu_ptr(), add raw_cpu_ptr()
  rcu: Document self-propagating callbacks
  srcu: Point call_srcu() to call_rcu() for detailed memory ordering
  rcu: Add CONFIG_RCU_LAZY delays to call_rcu() kernel-doc header
  rcu: Clarify RCU_LAZY and RCU_LAZY_DEFAULT_OFF help text
  rcu: Remove references to old grace-period-wait primitives

 Documentation/RCU/rcubarrier.rst        |  5 +----
 Documentation/RCU/stallwarn.rst         |  7 +++++++
 Documentation/core-api/this_cpu_ops.rst | 22 ++++++++++++++++------
 include/linux/rcupdate.h                | 17 +++++++----------
 kernel/rcu/Kconfig                      | 20 +++++++++++++-------
 kernel/rcu/srcutree.c                   |  8 ++++++--
 kernel/rcu/tree.c                       | 15 ++++++++++++++-
 7 files changed, 64 insertions(+), 30 deletions(-)

-- 
2.39.5 (Apple Git-154)

