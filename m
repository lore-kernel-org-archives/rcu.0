Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098331F1934
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 23:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740095515; cv=none; b=CfQ9Xv3ly0V2T6zZKhKTsLBM0JKBQXa06HLhw3XNQF49fRGnaPhZOU3bdjawxmnRKjvyj+Q2P4BMDpi8jVXiBuxoKEo5QHoaGJkoq+3AsaGuFNuNvzfDFF1pU8ZbgzHVKZ8zH253n1AEngo7JfYLnvgn8tt/Wj1egzVw9aJm5DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740095515; c=relaxed/simple;
	bh=vtOPXa8BnfbMCfX15af3q+cMPZ2p9MawIwGAHAHQBUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kcl/Yr4o0PrLISZOUDF8yfgfyYkSpbymeZwPuJ34NYuLAYeRjPa1gs07v/WqqjJYKm8YzHU/zmFkSerQb+avHle9MeCo/1g5LR7AcS28Kuw6gLHESXY2j1/6wdNCprPl9JpPpixxBnFyK1W8TBVD6uognKYwi4fUoMFtw67bslA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F9TzKXtt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F9TzKXtt"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KMp5Y7011936
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 23:51:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	K7rfm+etXdnbK/bhupbhOu+OTfhMZMjRNpbnrpPFumo=; b=F9TzKXttQBcvVdpA
	4mqLXqt9q62BpW0D8bH/BkUCb06gQnnqs8r+FbdAUaSGPYZ10oFqdHoLlCp/aqqA
	khIkbz13slmNuKyjzaU1yM4+YlddOBXv5MpZzZVDNhWjaJuh6T5ydC++gtNxkUVn
	kTdQYlyRxEJ4KkL2WdOdno4LDiWx11+khimC9rxAQAMw1UEr7w3uSyxt8LCubts8
	uI1hBMLMKidDWA+foCOHjmKTgo2jLo2l0ek1Mntee3ucb5HKIYjwhVK15K9uKYZP
	ea5T1Kll2QOLXVC2gYFkfV92Sqr1+DeSSjjgCzE7MboIq/iixtlDOZ2RLLm/f09p
	zwtHtw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44x2xb9yp7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 23:51:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so4642035a91.3
        for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 15:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740095512; x=1740700312;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7rfm+etXdnbK/bhupbhOu+OTfhMZMjRNpbnrpPFumo=;
        b=aXcC5BFhzZWvR72f+ot2agKRQ94f95vr+S1l9GgLMHYf3r3jpwMh8edgLDxXep37HD
         rLyrHBT0HAFqZ8bgm1P+mwV5wfMYnO4hIVmXKE9Pvj+JksS7eQ2bwh3SrDIaNBkSJoN8
         ERalNi1rDF01GLdTxYZgYZx82wXxUcv7z5nr1LziVVdMNyt1SNmv+uXTxAI+MPDH+5tD
         DNtLiMm+MNHJg0zSs5m67f1ue2Y8J+Eeptn0+mxqMdROlNUInl5kQDlRGR9VeaF/izWx
         qvvBtWJRV9PCN2o64H2C7FPKVYm7TrNtsqEY42WvXM9D/DQf/KApfn2ufA4bw5C+5cEL
         TkCw==
X-Gm-Message-State: AOJu0YwxU8FK1c440rO0xia+bPQ9ze98FzfzxsxSvRVWoPWEsv4J3X/S
	LBCJ/ej+SaquficjlwuZoJe8JJ8nNwx1pXkr2ja1QAPIiMUq617BXYT0n+thxxcEyWZfcBQTYfF
	0WNgNyngduai3e4QKQctE+DANTtsCvha2oH21OmLG21gEZpI8MjjOhrxMldk=
X-Gm-Gg: ASbGncsHdNDsTqRVHDEwbCLs4/J2lAu+NOTZYrV2uNj9Be7U5SRusM+NjMAkKFVjfMN
	IyQv7lpK/oNvuWtDFPgCa8xgu98Z++qKUbMFqOxBc3LKyu5F3uqn1huI2mMO8mwoDE95MN5XGVq
	9oVMOddjHOArXGZxZQIbyEgk/S7y42PTSi1XeJ0naothhe6E6FUSNCyUMhean6llr0TNs0aH03v
	tJz+InjiAgDM1aLaYNr0fDpf1TkdFg/kKGjR9xMGRtzskX+4ltAStmqKDCPUSWeLpv93LKXQLZA
	BaxuEUYZ5ZKAHHg7Y/s1uEnZxVgyZFsEgpWNPoXWie07vcZqaLce+fIUrIpR582oiMKxzdY/JA=
	=
X-Received: by 2002:a17:90b:2e44:b0:2ea:77d9:6345 with SMTP id 98e67ed59e1d1-2fce87244f6mr885578a91.22.1740095512009;
        Thu, 20 Feb 2025 15:51:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeRN2ESFgXnPd9OtGenw5lXipvYA29oO/tOIysMPDxjxWiyqAI15+Vg9TfM3kmmfB3zBrreQ==
X-Received: by 2002:a17:90b:2e44:b0:2ea:77d9:6345 with SMTP id 98e67ed59e1d1-2fce87244f6mr885554a91.22.1740095511638;
        Thu, 20 Feb 2025 15:51:51 -0800 (PST)
Received: from [192.168.1.111] (c-73-202-227-126.hsd1.ca.comcast.net. [73.202.227.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fcb8571586sm2111645a91.0.2025.02.20.15.51.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 15:51:51 -0800 (PST)
Message-ID: <ea5341a5-a5c6-4214-96c3-32d668ce3f11@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 15:51:50 -0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 1/9] rcu: Add lockdep_assert_in_rcu_read_lock() and
 friends
To: paulmck@kernel.org
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, Jens Axboe <axboe@kernel.dk>,
        ath12k@lists.infradead.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-1-paulmck@kernel.org>
 <9130e3da-1cc5-43ea-9153-47117d57caca@oss.qualcomm.com>
 <67063387-6ba9-47fe-b283-d6346da15d9a@paulmck-laptop>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <67063387-6ba9-47fe-b283-d6346da15d9a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 6LuP9Q5aODE6P0ehyCuJ1LiyPTxWdyGx
X-Proofpoint-ORIG-GUID: 6LuP9Q5aODE6P0ehyCuJ1LiyPTxWdyGx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_09,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 mlxlogscore=905 clxscore=1015 priorityscore=1501 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200158

On 2/20/2025 2:04 PM, Paul E. McKenney wrote:
> On Thu, Feb 20, 2025 at 11:38:14AM -0800, Jeff Johnson wrote:
>> On 6/4/24 15:23, Paul E. McKenney wrote:
>>> There is no direct RCU counterpart to lockdep_assert_irqs_disabled()
>>> and friends.  Although it is possible to construct them, it would
>>> be more convenient to have the following lockdep assertions:
>>>
>>> lockdep_assert_in_rcu_read_lock()
>>> lockdep_assert_in_rcu_read_lock_bh()
>>> lockdep_assert_in_rcu_read_lock_sched()
>>> lockdep_assert_in_rcu_reader()
>>>
>>> This commit therefore creates them.
>>
>> I'm looking at some downstream code that is trying to become
>> upstream compliant, and currently that code uses:
>>
>> 	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "some message");
>>
>> It seems like this would be a good use of one of these helper
>> functions, but I'm shocked to see that no upstream code is using
>> them yet.
>>
>> Is there a reason to not use these helpers?
> 
> In cases where there is no additional useful information that can be
> placed in "some message", the new helpers should be just fine.

Thanks for the confirmation, Paul!

/jeff
