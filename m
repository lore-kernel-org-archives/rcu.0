Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533489;
	b=2Jdnp7hQEwB+3dvJ8z4VBe+G9fvmtM2fsoFn74k0K3Bl/5UOjI+wWMPXGcksFfaI2cFn
	 PBiVKWC2PD0jkm96Fr+t/+EPUwEH7UIWtldDwr0cpRpjk79HC4DmSr7FtduPfQRUXuuQZ
	 e8Ahg8DtJSIXPSTFA83tXqXdgfy5Oh9JHtMVNyxVPA5EMWnCsmfFijcARBQb0zDLzhCbL
	 3EhhdpvyycKh2Wj/t09rDej2rw0xeLavOgALjwP2//1pmA4Y9nlO6jHfVzwrrGhI/05Qe
	 c/ZEFbJRaBS/iLXEYJ4C9HoUBn9PswokVmB9MnHRJLfMyJbk4hpGnL4NBMVVyqSGg5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533489;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oqyJWamYBJxq+jEb/AG04JWYCWpTDYqf7zDMnJ+2noc=;
	b=HX2ttQ51192saZmKGMOOCiEoHfCLZ2x+Z6Vpq9IAk0Ll1qD/1CxcAUfC20EwD8lQwGw8
	 B1c9nGJpEYjy4sbL09bmLkZQgyQRIqeH9j/2BPpA+TD4odz/JxFu4c7Gbh15swUdZg2KC
	 9/nH1+mer+JJtmRoIP4UYeGzL1+vPUasJ+T5dvEbPwO3TwEANj34yjXO0aYw2SychxESX
	 kplVXEjxSneWC+kbCbsGGreRiu15h08sFnHFnf2ZCdrBmRVQBpxvI+tjTO101enCqWfnW
	 doJR42RQ7tuUfO2H6+5KfjtzjzWSH88kx+7zTFAjTD8/f2NVIPbE5Re4tgPCmBmc6iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gyKQmLKu;
	arc=none smtp.remote-ip=95.215.58.47
Received: from mta1.migadu.com (out-47.mta1.migadu.com [95.215.58.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF67606A321
	for <rcu@vger.kernel.org>; Fri, 13 Nov 2026 01:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF67606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gyKQmLKu
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=4mNA24lWFtHkqGkDQ70hiaByiqDolVJTxo+Az4AGD24=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794533486; v=1; x=1795138286;
 b=gyKQmLKu+ZboIgLBayNC9N0yjRXSsJoszFhKDbpjPeo1aUdrgiGho7y+1DX9hkPnVX0T2GHp
 zcpEJkT5Bheih/iNppTNKKwbJJC+ik80xd5M/r96vyu6jaRcpNoXasGzptNSwf0k6yXOyoeZ/5w
 MbkVS/m+GfVLgLOXi3UOZsSY=
X-Envelope-To: rcu@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 0c591094c78f7cf0;
	Fri, 13 Nov 2026 01:31:26 +0000
X-Mizu-Trace-ID: 0c591094c78f7cf0
X-Migadu-Flow: FLOW_OUT
From: xiongwei.song@linux.dev
To: alexs@kernel.org,
	si.yanteng@linux.dev,
	dzm91@hust.edu.cn
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	paulmck@kernel.org,
	linux-doc@vger.kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiongwei Song <xiongwei.song@linux.dev>
Subject: [PATCH 0/2] Add RCU docs Chinese translation 
Date: Fri, 13 Nov 2026 09:30:21 +0800
Message-ID: <20261113013054.5662-1-xiongwei.song@linux.dev>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiongwei Song <xiongwei.song@linux.dev>

The following 2 patches are adding RCU docs Chinese translation for the first
time. 

Currently, RCU is not listed in TODOList in subsystem-apis.rst. I propose
adding it.

Thank you

Xiongwei Song (2):
  docs/zh_CN: Add RCU/index.rst translation
  docs/zh_CN: Add RCU/whatisRCU.rst Chinese translation

 .../translations/zh_CN/RCU/index.rst          |   50 +
 .../translations/zh_CN/RCU/whatisRCU.rst      | 1220 +++++++++++++++++
 .../translations/zh_CN/subsystem-apis.rst     |    1 +
 3 files changed, 1271 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/RCU/index.rst
 create mode 100644 Documentation/translations/zh_CN/RCU/whatisRCU.rst

-- 
2.52.0

