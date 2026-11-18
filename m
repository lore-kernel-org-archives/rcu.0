Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795007823;
	b=UMpbM7lIFkAbUdPAjJ+uc20gZvFPvU9+esEC1C0UM+/r+t8OmIlsHLV+qjRDRHV19B6l
	 mZVe7RNlrEcuOD3RQPqBEhR+i2Sp65BmJ4KSXnScmooy4emTYPitm1jc8MePl07ce3wxV
	 vX9R15La+cZeoDVE4qX1mjx5eD6YjFyBZ+JGPtkbU29sHVK11pZSXdYz4jhdhqfBT98kr
	 BDkqz7gTEGEK9DK2DqBIBdH0NMyuTUIFH8frgbnIlCcw4/PBllDc1W9pqzFu/M0gbyQul
	 7oZHrKy9wJJT0rR5OMydQBslM3iJrlIfTjqbxzSxCHBqnYjWqGMBB+VUOsARuos1rYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007823;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Zmfk0UiuIYcl8UbsrERw8AcNgTEWYppM5yTU6jwtjIk=;
	b=RhQwjwJbZfSsk1keFZydWwgufAZJ/UEVFQAJsGWYl/tCQzOPof8D56pZ4HvtcUVZ4Ju+
	 i3KLua8Bq0CSwDDxFlaia6PUst8UKuNG9Ul1kh455MYfKw67O2RgtPVee/5vcbNO8jND1
	 e/wLiAjX94m+KQVWVvKBdeVR0t210N/UCmFYcD6jiECXWq85xvzeTQGldrPBs752Snnq5
	 CxyLvwzUaITfcxc7dAdJJH52EZzXpFdQhVfR5K6VgIQHikk5peLsnX3kYueggCKm3qxZj
	 AmLPgpoccD+6AUWzxOBrnm0xSBca+/4qib6hdWlsBGzLf48X+xx0LFJI86XitNOn0xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MKArAhwW;
	arc=none smtp.remote-ip=95.215.58.3
Received: from mta1.migadu.com (out-3.mta1.migadu.com [95.215.58.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814C1606A320
	for <rcu@vger.kernel.org>; Wed, 18 Nov 2026 13:17:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814C1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=MKArAhwW
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AMzdrRLfDWMyU7UGPCZYwpksO2SRu8ahw0yiAFS/GEo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795007820; v=1; x=1795612620;
 b=MKArAhwWH781JhqEUl4kvHvV3QaFt8DM8XQ0fFz+W516O9rJzBvpronubTanVVVpTtG/OWVJ
 oYCcROeaP+kqfv8atHT9qCCcQVOMigJ8JNvsrYnW2klrdC7pBiUhJK68RgJ9j7/n8OkVybVofRo
 bvd7mFwl9tXf/9tTg57sVxXw=
X-Envelope-To: rcu@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 268c1a0a607b1246;
	Wed, 18 Nov 2026 13:17:00 +0000
X-Mizu-Trace-ID: 268c1a0a607b1246
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
Subject: [PATCH v2 0/2] Add RCU docs Chinese translation 
Date: Wed, 18 Nov 2026 21:16:32 +0800
Message-ID: <20261118131636.5131-1-xiongwei.song@linux.dev>
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

Changes for v2:
	Fixed build warnings and errors for both RCU/index.rst and RCU/whatisRCU.rst.

v1: 
	https://lore.kernel.org/linux-doc/20261113013054.5662-1-xiongwei.song@linux.dev/

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

