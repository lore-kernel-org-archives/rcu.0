Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A20D214203
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 19:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080302; cv=none; b=Q0YZ5conMcMcMW9omzsYMhzy3jj/XRcLrgSWAtmuYSv6gLxLJdF882MKwna5o8Q1EwES5gaslsI7gr6WRs5Ol3k0pC5JLCMv6dQEIb9xQotNTt5rFI3H8xg/cyjJTD5sRqUCEIV8th7BP8q/8rTBKk/lUC60mVKXsb8e/yM0A+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080302; c=relaxed/simple;
	bh=jJTRmkl8BS0UGkrlf/FQ7MLpehgrdAAxAkqRNaksRO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vBroeTN0plvAqpxcB8Kbq2AL/oOA5xnNYH01VZB9K2RVzAX5Ha2GO4InRIXhfn8njkbeEf+hRDQQt3nBBf9LjUoMpjYRhwgWew5LGpaVyTH4GycDqEVdLhi/xWeb5JnDDrW0kzpgx3qxOh0eauNoDFebbFUayI787zPzsGQ88lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kbHcZnTx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kbHcZnTx"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFc7cQ008326
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 19:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0AoN9J0kuIuOV/ZPo1+2Be8EtAGksOa0fida19aIYeo=; b=kbHcZnTxhLq0z03x
	yyL8cJIVZiT9As/VrlEZrOTYBT5rjChkzNqNz88Hb8FvNgBUPdeu6kOhBwX/Sg42
	E5f/XzYY7y2XBCi/MHAllvcheQSAl1HL8/nCx7ZaIT52rHlvmK9bQRT/85DtQD5n
	6mF9HEdDtt9Znc1GMoNN1xi/6FSGhNKOG5LKNob6wRrnqiGuto/lcSRRlq6El6u4
	8f8P5rNUxWIKJenxEPnB5ao60U8Tn3T+QaNjfj/FtbYmLsmep/yCdR6V+zpKCOo6
	cFIlERDKsFoyxVJwsmp1dw4aqNtC4RJV9PvJt0WfKt+uefea7mmMbUgxbM52hobz
	Pq7k8A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44vyy3f8xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 19:38:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05bb5so2799231a91.2
        for <rcu@vger.kernel.org>; Thu, 20 Feb 2025 11:38:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740080298; x=1740685098;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AoN9J0kuIuOV/ZPo1+2Be8EtAGksOa0fida19aIYeo=;
        b=pSh4by79a8Nt0pm5LDdDmtOVgAv1bu+RwdoFVvlXeNWd848LnbDoJx1IdTm39bZQ9K
         l9zLE5KaUSUrn47H3e2MIBp2XH9EVsdbdOEshpC70ybzoGep5dK7Xwgwe68Gy2YKDVGn
         e00/NNqYwDuxBGgAeVdm8khrruPMYoUgf+KshHtD6qRnMRz0TcdkWO+/OCXSqGzTxf5t
         IIakuSBZiBTuOnX1LC8mCFthV+QPhtR39KPBIBSQbsbqnDm/X615tJoC5tkQTYg3bKcP
         23GV0W7WPSuBYhRvUqU6RVJwCK8A3o5Rczd/jCv/yfl6JKFrg5UWjydGOfMfXQDRQ+FN
         fCjw==
X-Forwarded-Encrypted: i=1; AJvYcCWX70iFN5YdeEE/oVr07zeD5p5uYt3yyzjcOBeGVZgXzZtDmy5DakPAcNXakEUZCpEc54o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hc06uCyorHN5ovW+rUXnsw/5i8nZFbDU/dzReCH2PY92SYo1
	9HM4mfSZKy86Nvh2N5fGohMJ+d9CD9hTNGv7/KiYKD6F6ZyZkEAOLJvUHanGRL7QB4Cg+upZRf6
	XWv4kilRhfycMR5DPw1me6sTTKvapSc0MrYz/C8yqbvMmf1Jhd6E=
X-Gm-Gg: ASbGncut9wI+v4vH4XvZyK2mH8mo1oIyrClGTXLYOPH7GDV/knsv5Q0jvfiTbTlCOC7
	qPAm2qL6zteaZQpjwWeUKP6Fae51pK4+ktpNHLmHUb1dkF5QQLyVDGNHiNy+XMVn4W1ypneVjed
	ugGsGW9AgbvGKoIKC8Imn+GiFCsqpT7n1EJATwyuVocFwEh7WcxZMhVYRQSiK7OWnkkZsNZ+VSU
	wOL0VQGm6aqEeDcBVJJeV0tqidBDmZ1yhMBj/8D0yMDjuplZpp0LxdeNFZ3bV/Y86y/d3KbLsdT
	ggLEVlo14CZXdQ2ozsIlewlXlqQjo4TcN8A5oeJsaA==
X-Received: by 2002:a05:6a00:21cb:b0:730:9752:d034 with SMTP id d2e1a72fcca58-73426c8dc32mr181853b3a.1.1740080296893;
        Thu, 20 Feb 2025 11:38:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZm2Yu7G5eVKjrzJZWgkNOaHv76I2dubfx+gNozinPzrqpaGLN5qXhYqaV0mZ+TfLWhdDO1w==
X-Received: by 2002:a05:6a00:21cb:b0:730:9752:d034 with SMTP id d2e1a72fcca58-73426c8dc32mr181822b3a.1.1740080296420;
        Thu, 20 Feb 2025 11:38:16 -0800 (PST)
Received: from [10.81.24.74] (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7325ce41326sm11600669b3a.93.2025.02.20.11.38.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 11:38:16 -0800 (PST)
Message-ID: <9130e3da-1cc5-43ea-9153-47117d57caca@oss.qualcomm.com>
Date: Thu, 20 Feb 2025 11:38:14 -0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rcu 1/9] rcu: Add lockdep_assert_in_rcu_read_lock() and
 friends
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
        Jens Axboe <axboe@kernel.dk>, ath12k@lists.infradead.org
References: <657595c8-e86c-4594-a5b1-3c64a8275607@paulmck-laptop>
 <20240604222355.2370768-1-paulmck@kernel.org>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20240604222355.2370768-1-paulmck@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: nEJtteiTkR5TVfIfXzS-nsSJDpiizrzK
X-Proofpoint-GUID: nEJtteiTkR5TVfIfXzS-nsSJDpiizrzK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 mlxlogscore=996 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502200132

On 6/4/24 15:23, Paul E. McKenney wrote:
> There is no direct RCU counterpart to lockdep_assert_irqs_disabled()
> and friends.  Although it is possible to construct them, it would
> be more convenient to have the following lockdep assertions:
> 
> lockdep_assert_in_rcu_read_lock()
> lockdep_assert_in_rcu_read_lock_bh()
> lockdep_assert_in_rcu_read_lock_sched()
> lockdep_assert_in_rcu_reader()
> 
> This commit therefore creates them.

I'm looking at some downstream code that is trying to become
upstream compliant, and currently that code uses:

	RCU_LOCKDEP_WARN(!rcu_read_lock_held(), "some message");

It seems like this would be a good use of one of these helper
functions, but I'm shocked to see that no upstream code is using
them yet.

Is there a reason to not use these helpers?

/jeff
