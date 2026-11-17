Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.251
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794908891;
	b=1Ihk6jcKX4xaF6n38xwLpnQ7/tuv2PQybgFSVGpj9VoRAmqoSIBY1MLy4ywxg0JCSLE7
	 o9ZC/MUg5tvCJiWl4Nna6uwaZ/WHiAdYOqI0z0G4vLUAu3Q4tjz5NP3txuVtrPOayJNUk
	 yQnVtDJ/KpMiU/HYLQ+wKHyrNiUbwFwINiliMDOyrm7iZ5muTEs/53x/BQhQLqHNJ1Pd0
	 cXyWkSQIPJKv7TdxVSIQHbtiTP/IUOx0Q+MKDi7NYY1gRPCuLmgL65n8MOLMvrjecirzu
	 qO11NNnLEWgj9zASlMAe/1Ze+Wxmat83Q8bBkXL43zJMuOcCWMWjU0p4pBL2z7OW9RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794908891;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=I5sVUKl6IsToBH8GKIsDkD3iYiKyw4udJuS37TkMCAk=;
	b=IWi7uq3eGCPEdKWx76VHoQ4cGkrBuzqnPWxaSr/YHpwchvc5PiFOqeMXfSGuylEziNvX
	 2nFnMxKQGtx2LdWV6NV7KGEjzpdcrm1LxcW0hhMf2fjJRnH8/9dRA0/8Lb19Rij86pv2k
	 5XY5RqeIFRaL7Alb6CdItY43fDHV6UcWD9sRsqwNgx4v5QPO/LBQcvTDQhiRelB9GdsFX
	 y9sv8VZcoKhQ7D6HZ5Tw0fEXotIjRELsM0R4Do0TY6ogx+C7kwVmkh7TeEQQDylfUleO5
	 +BBV4t0/ur78b5WHqNQDlVqaekbuir72RWjeFSTtFNESjeK5Z2Nd88AWRzBxFjNWzqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NUZ3fZBA;
	arc=none smtp.remote-ip=91.218.175.251
Received: from mta0.migadu.com (out-251.mta0.migadu.com [91.218.175.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF72B606A881
	for <rcu@vger.kernel.org>; Tue, 17 Nov 2026 09:48:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF72B606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NUZ3fZBA
X-Envelope-To: rcu@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=pPaw2gzK6hN/EJShUwGAR9CIOc/CcWuDR+oCu2qd/Oc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794908889; v=1; x=1795513689;
 b=NUZ3fZBADi1MxVE2/cJePO0tzqLrdqEEVUo/jnsls12/tEhu4rQuIj4R79DEmD4mcKuX/Hrq
 p66nbqTsP9GB0Ujo0q/teRCCVUHPhzmRULPpdx5Z9ieWSPhBUyMgD88wTdGcIJNicKyXMl3uc0B
 OHBfmkpgNZ3ZavHG830+0Wv0=
X-Envelope-To: rcu@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7f64ba229d2a7300;
	Tue, 17 Nov 2026 09:48:09 +0000
X-Mizu-Trace-ID: 7f64ba229d2a7300
X-Migadu-Flow: FLOW_OUT
Message-ID: <415e7ae2-e7f9-4199-8de4-49819cd2c9e3@linux.dev>
Date: Tue, 17 Nov 2026 17:48:03 +0800
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
Subject: Re: [PATCH 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese translation
To: Dongliang Mu <dzm91@hust.edu.cn>, alexs@kernel.org, si.yanteng@linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 paulmck@kernel.org, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113013054.5662-1-xiongwei.song@linux.dev>
 <20261113013054.5662-3-xiongwei.song@linux.dev>
 <a96526ff-660b-4c02-85cd-c00b12c483c9@hust.edu.cn>
From: Bruce Song <xiongwei.song@linux.dev>
In-Reply-To: <a96526ff-660b-4c02-85cd-c00b12c483c9@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/16/2026 11:05 PM, Dongliang Mu wrote:
> 
> On 11/13/26 9:30 AM, xiongwei.song@linux.dev wrote:
>> From: Xiongwei Song <xiongwei.song@linux.dev>
>>
>> Translate .../RCU/whatisRCU.rst into Chinese.
>>
>> Update the translation through commit b3eb16109ae1
>> ("doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU")
>>
>> Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> 
> My sphinx complains about the follows errors and warnings, please double 
> check and revise the translation to make sphinx happy :)
> 
> Dongliang Mu
> 
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:253:
>    ERROR: Unknown target name: "1".
> 
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:268:
>    ERROR: Unknown target name: "2".
> 
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:15:
>    WARNING: duplicate label whatisrcu_doc
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:77:
>    WARNING: duplicate label 1_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:124:
>    WARNING: duplicate label 2_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:351:
>    WARNING: duplicate label 3_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:435:
>    WARNING: duplicate label 4_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:528:
>    WARNING: duplicate label 5_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:603:
>    WARNING: duplicate label quiz_1
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:650:
>    WARNING: duplicate label quiz_2
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:657:
>    WARNING: duplicate label quiz_3
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:666:
>    WARNING: duplicate label 6_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:788:
>    WARNING: duplicate label 7_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:854:
>    WARNING: duplicate label 8_whatisrcu
> Documentation/translations/zh_CN/RCU/whatisRCU.rst:1135:
>    WARNING: duplicate label 9_whatisrcu

Thank you, Dongliang.

Again, I didn't notice these errors and warnings when building them
myself. I will fix them and resend the patch.

Thanks,
Xiongwei
