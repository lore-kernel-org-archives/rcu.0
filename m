Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.62
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795700153;
	b=AJFimKXRTA0FkyLGO0HSwF85DGq0MZJ4rvxBrpCEYtrS5kgwtx59Kqh+J1y78CBtmSiM
	 jKO9vBhUrnbz60jqtV1EA9xTBSlVIv5fbgYLDobQYrEuk2Kvz18KZgyuB7jlgZa3N/10h
	 zwPZ2w4OlvwV/U0cw+Q84chERL6SaAEOrSjCTMRXiN0itQE8JXRiqKK3EH/ZA+EvhXrSt
	 dZ5JZjLS3rF0c6PemslFOK3xBCcsebe74oXYVGRbxr7GWhfOIB0HmS3NCf67WBL9U7nPQ
	 aXuV4J2HJ29P8G5McDUgRsTRc7aR6TqlWkcIBwJdpISLbzCB1T7BLRetDsC94ozP8XA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795700153;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Xb09k+Q7S+nusy1E9oGvKPTatGNmG4h5RDxHcIpii4U=;
	b=U4DpsKkwergu97CEjdHKRn/M4ugrVvpaHiPgGkrDTuF5nEq8K2+EofL0L06kqWombBIf
	 MNzu/goiTLc2NhP6FgEB//RwW89DHsNRHAbl7ya1FkNMgybXo31S7IR/FrOp/MX96fLFS
	 sKIGE5CqeV0lI6K4RjS01DqI9sfQy0MT/Z6IVh2HiZwZlLF2xbqvzJEjdg6tY7TFd8vmp
	 HVeWn1SuwNqnKmuaex+3WEvEfX4j7WOwqQHp+ZCwU63VlvDlfiPr09O9a2NjnxNY4OyHy
	 QQac6iK5ZhyO/3UZWuZuey+iHhJJt+/PGkK355NFHF+aBoTFq2modCTK+iTuAxiQrpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CObOpJZm;
	arc=none smtp.remote-ip=95.215.58.62
Received: from mta1.migadu.com (out-62.mta1.migadu.com [95.215.58.62])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C8E606A31C
	for <rcu@vger.kernel.org>; Thu, 26 Nov 2026 13:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04C8E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CObOpJZm
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=dUdgIW56zc2LmSVw8C0r8LZdqQmDkcHedRF69L+C9RU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795700150; v=1; x=1796304950;
 b=CObOpJZmLdQcR1KhwsX1sJzeNLJrle2kxiHgKrfXFVKhRL1cnhQQhTnA2mfd0SdtdM7Sfe1f
 9pq0+f1cgSqSZYwm71e+W9KMV2t1+nG8AvXi+pc1u1+fxfCwTHbEbLk99nJnNauUwT1AoRXhI2T
 2NfVFzJBJqaLG5HNQ9BvLKIw=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b52514b2ec1a5b2;
	Thu, 26 Nov 2026 13:35:37 +0000
X-Mizu-Trace-ID: 6b52514b2ec1a5b2
X-Migadu-Flow: FLOW_OUT
Message-ID: <0d5126e6-7588-4cf7-90de-0bd193db8246@linux.dev>
Date: Thu, 26 Nov 2026 21:35:28 +0800
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Add RCU docs Chinese translation
To: alexs@kernel.org, si.yanteng@linux.dev, dzm91@hust.edu.cn, wy@wyuan.org
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 paulmck@kernel.org, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261126132523.6329-1-xiongwei.song@linux.dev>
From: Bruce Song <xiongwei.song@linux.dev>
In-Reply-To: <20261126132523.6329-1-xiongwei.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Sorry for the noise. git send-email returned "timeout" after the cover 
letter was sent out. So I resent v3 of the series. Please ignore this one.

Regards,
Xiongwei

On 11/26/2026 9:25 PM, xiongwei.song@linux.dev wrote:
> From: Xiongwei Song <xiongwei.song@linux.dev>
> 
> Changes in v3:
> 	- Some translation improvements.
> 	- Deleted unused label.
> 	- Fixed indentation warnings.
> 
> Changes in v2:
> 	- Fixed build warnings and errors for both RCU/index.rst and RCU/whatisRCU.rst.
> 	https://lore.kernel.org/all/20261118131636.5131-1-xiongwei.song@linux.dev/
> 
> v1:
> 	https://lore.kernel.org/linux-doc/20261113013054.5662-1-xiongwei.song@linux.dev/
> 
> The following 2 patches are adding RCU docs Chinese translation for the first
> time.
> 
> Currently, RCU is not listed in TODOList in subsystem-apis.rst. I propose
> adding it.
> 
> Thank you
> 
> Xiongwei Song (2):
>    docs/zh_CN: Add RCU/index.rst translation
>    docs/zh_CN: Add RCU/whatisRCU.rst Chinese translation
> 
>   .../translations/zh_CN/RCU/index.rst          |   50 +
>   .../translations/zh_CN/RCU/whatisRCU.rst      | 1218 +++++++++++++++++
>   .../translations/zh_CN/subsystem-apis.rst     |    1 +
>   3 files changed, 1269 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/RCU/index.rst
>   create mode 100644 Documentation/translations/zh_CN/RCU/whatisRCU.rst
> 

