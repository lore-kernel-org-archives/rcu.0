Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DA364EBF
	for <rcu@vger.kernel.org>; Wed,  7 Jan 2026 15:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767798622; cv=none; b=gyhtYo86QNk5E8Jcgs/EtlsXWCEBx7py4wcidADaUhOsL3BkQqFasRZ8TG17D7ZObG2ZitfYVvzN5cQ2VYb5j/HDzSAAAqw66DXsb5xXUztXAkB5zurRFcjJvORW8dnN9uzWG92WUSG/BLI+YQ54x9DZDCICTmlwer5944mG0BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767798622; c=relaxed/simple;
	bh=WubH+O1/8hBTAxWCztE9WKkBJcmFAadkVRd98AR3Ut8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LXMY4JiWa2ezssprG7cQXMIiSjrPSW/0hYgIGlR7QdVJgAMs9YTtOynxoaD+e/iH8xXq/W33e3yTNMCCvbYADdh4s2K3AlHEvtmTQSqSkKDTLltmT/z28i28Sm2/DeJ9Y0dUwpIH4xPmKBQxm4Ak9xQfFapO/wei35TYsjCBVB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AX6FlKkW; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AX6FlKkW"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7c75b829eb6so1383860a34.1
        for <rcu@vger.kernel.org>; Wed, 07 Jan 2026 07:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1767798619; x=1768403419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k0bHtr3XrySAFjiImEQ7o1sCcWtYIi2aFyl2Uu893iE=;
        b=AX6FlKkWXwCF117h0wwAy0zW4+jBKKisWVx1earKNhcoh0bovCLaCLrqIh4VXkC35H
         fbneaMg4YC88VcMcYCK0pCiL/JJ+tZSIxENyJcpuBHcIPB1WMUN/yMAyZvt4wFO1vAC/
         QsE4L4wPG1vRuO4NyWTIcD376fmu0MnjPDDl/uit2o/WfP/9rzFjRSTgudf/iZ1g358I
         9denddbZwtqK3pJoFSDi1OmG3dNmGw9fGgfOTBfhHkjSuqLVUL/IOxMNcU8kQGP5q8Cs
         TFzf/Lwh4myayuUerL9QK0KXLNdn1vAZalk4g13lCkWqAAKN4l9ELfGn7HBQ139Dzjql
         zt0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767798619; x=1768403419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0bHtr3XrySAFjiImEQ7o1sCcWtYIi2aFyl2Uu893iE=;
        b=M7YiLymERghVDphSNGCxzQB4xUljHUOsK3BSrS8P2X5D8WxhlAclg9GBf6Pj5gPx/7
         9TSyGdqxT6puFg4scS/2nGE6amnlCYS+dVbiZAAMzSuLEd2uBbIlSgkaASW95gDvghq1
         AUOzFHrMp9ZYBxVZKj561GVV3DdEQJvuIYfD9KB72wa32aptKBG9mCRf47vZeovNqjwE
         eF1NB+XH2dLz/elR5ApUwdf/eHedvBm2qGrmCzm/m0JwNa78XKN4Q+fI6gasA0czfieg
         Fs5gDsE4pvXoFBM+Eeo9WiySGQQDLYd9Uz7p6/CErTPDzNjWhOTm0JwUjL32+Qma5Ng6
         G1wg==
X-Forwarded-Encrypted: i=1; AJvYcCVIIgEwIjuylU/QR/Y23F3NXqesUsmONGMLLekOSnrHolN4INf7RJ/TAGjsSq0jynQ8IZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGl1HU8q8NsxqXT2sg/nv/G4zlKlckiwqVcSP35n/asPFPdYKl
	um3iEYyObOsOH2PgnqMnVMOpoAbf8gNPacYpR2RFwIzqZA5SDJN98s/yLtbnlPSATZkmUHsLJ9A
	PbfxM
X-Gm-Gg: AY/fxX7b6h9kSpo1H1k9Yrz7n5XY9a+V9w9P02kcv5PvdZp8nPRaf0aIwJyaMinyiBD
	FASArEORWSsZAeDPybQUe7T+MxgmDo0Xajvjjw5k+tzTKYvxOjduVKPsraXUzwnqVcNmIkm+Hw8
	2guQkPX7msl2BTHx+l1l+xdnRyak+M5lpXWIl7/O1zRSIztVOBmPWH1QSfuET1IVqCzuXegDGMH
	CX7MxDBTHAEW+L2M6h2feDQJRFA6FbqALZOY/zlS1tZaBbYxKVeJ5DGlTfAbS/WI5GWF00e3VqI
	Urqiq8YtpPzX1zAEWNbXR8D+7mTPx4a0xE1BStOULub+GKPWcMEZrf4YLcckDY2TwXB/HkXgqrp
	/8CIb4zpRJXxHXinXyOfG8QR6dOwILUKiFOCPkQ/RitOBPv3hbz0pk1Cg3+eSXqfVeG2Z6JJSRn
	IrkMAqOE0=
X-Google-Smtp-Source: AGHT+IGj0/K418ShDqcpkHparrMPXls8h5YWHeYgRgBCKWD0/FEozHczhl59mfKwy194ChwkeK4zzQ==
X-Received: by 2002:a05:6830:2b22:b0:7c7:591a:7e91 with SMTP id 46e09a7af769-7ce508a5f84mr1808668a34.7.1767798618749;
        Wed, 07 Jan 2026 07:10:18 -0800 (PST)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce47801d4dsm3485794a34.5.2026.01.07.07.10.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 07:10:18 -0800 (PST)
Message-ID: <6fe15c1b-2990-4cd1-80f2-a9f37a67166f@kernel.dk>
Date: Wed, 7 Jan 2026 08:10:16 -0700
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: avoid stall during boot due to
 synchronize_rcu_expedited
To: Mikulas Patocka <mpatocka@redhat.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: Fengnan Chang <fengnanchang@gmail.com>, Yu Kuai <yukuai3@huawei.com>,
 Fengnan Chang <changfengnan@bytedance.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett
 <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 rcu@vger.kernel.org, linux-block@vger.kernel.org
References: <8e5d6c26-4854-74f8-9f44-fdb1b74cf3c4@redhat.com>
 <aV04Vp3nmCg41YZD@pc636> <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2720e388-9341-34af-21c5-0e5e1a822960@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/6/26 9:59 AM, Mikulas Patocka wrote:
> @@ -4553,8 +4566,14 @@ static void __blk_mq_realloc_hw_ctxs(str
>  		 * Make sure reading the old queue_hw_ctx from other
>  		 * context concurrently won't trigger uaf.
>  		 */
> -		synchronize_rcu_expedited();
> -		kfree(hctxs);
> +		r = kmalloc(sizeof(struct rcu_free_hctxs), GFP_KERNEL);
> +		if (!r) {
> +			synchronize_rcu_expedited();
> +			kfree(hctxs);
> +		} else {
> +			r->hctxs = hctxs;
> +			call_rcu(&r->head, rcu_free_hctxs);
> +		}
>  		hctxs = new_hctxs;
>  	}

This is worse in every conceivable way, imho. The proper way to do this
would be to embed the rcu_head in whatever is allocated for the hctxs at
alloc time, if youre doing an alloc here you may as well just use
kfree_rcu_mightsleep() in the first place. There's nothing gained from
open coding that.

Since kfree_rcu_mightsleep() will only run into trouble under strained
conditions anyway, I think the original patch is fine for this.

-- 
Jens Axboe
