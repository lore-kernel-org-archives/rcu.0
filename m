Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480DBAD2C
	for <rcu@vger.kernel.org>; Tue, 12 Mar 2024 03:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710213863; cv=none; b=r04GVmfEnIOHgsT809O4x4zPn2+ud7HtsB9k130Nf7jdXlisoLMorpKu/cyxo6Lj/7LX3VOCGGA3I5fSeirccyxctVQUMh1/k/XoUMB0PPDpOJBwEZzDwVUDDGDiOvy9RZmYenS0iPQZB3/oFGDNIH9xvYErzJtnmddt5q19ZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710213863; c=relaxed/simple;
	bh=ya0U1g9V0o6+rM4JHioaEtve3TkGYKYyIDMqwy3dDq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH6a2/96c++9TIv7yihKJ1yQqA1SlBHnoEqZq+uMwDzlPFDj7+ywGrnRe5+0ldDfbG/XLt1fEH79q64mvOrLQb2w7i6KQX6hmbXt/Z5sKlmtk5acb88wSDDhBUxbKtMv2putpAvVwT2J/ShyDZHX0GBErNWrvx6sb3GE3xwXHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=rpY+IOhT; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rpY+IOhT"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-690ca2d2c5bso14172726d6.2
        for <rcu@vger.kernel.org>; Mon, 11 Mar 2024 20:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1710213861; x=1710818661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zuZlZeeJSyLwb3VYggdW0U3QHr53BLifrVnBVoQd+7U=;
        b=rpY+IOhTIXcaZauz1mVQ7KanabzjzmrBKUecJvauntl6inPUIA2C/jrq3XNoGp+OQn
         9N9Al+RNeTsj5jIBDrAvn1V2zMpZpGPxmF5jsFJjT65i6flpNnYXTk3T06OERZFstuF9
         xDMAQfEcT37mncbH3OWkuVU7+zrHa8apBVqFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710213861; x=1710818661;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zuZlZeeJSyLwb3VYggdW0U3QHr53BLifrVnBVoQd+7U=;
        b=Cp5kvVnY5GgVQHPlsPbqcC5zYQmN1JqJ9Td3nnOG774w/wXmRX75eW72YzDra2ltyZ
         dqRwYqMdrWVrD+T99X54Q0xtRnKo4Clba3oGMzdF2KW0teCjbZQI0yGyq/UklThJ+fJ6
         a51MrzP4Hgc/4lP86KVIxwd082vrk85k/y4/fV0xJDHOu7/ttX7DB9jo2eLSy8PEcR9S
         2D50jkeicNDB/hgdshVJM9q3NQ20EVCKvgAXaU0aoyG76TWuk2h7gQO43Jnfw7Wie+nz
         enjfdAL6nbHK0mmTCcNk4mp1LPcFFMURHCt+z303m5/Megh9iJT58ywrEGWz/aGV5Nv8
         TTeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGwlFIXbbWIuMOVVDh7A3jFW7SLqkN1R/xlCt+5LQm+bxaR7PZO2goxidypf4qMZL4AroPODvRs/JcDNz2LzbbcHSG
X-Gm-Message-State: AOJu0Yz1X5weoqMbs5xXZIvm3ZoWFDiNZGdPu063alpymqO3fGkG7qV/
	pb2iW+Iv3f+q5MYm59PZmIQJDmOftV/wBJ9YzI4F1XCT/aiCIPWlMTu39Jt3Ci8=
X-Google-Smtp-Source: AGHT+IFi8KMDOm0HfnDxyEdYWRSw43EdNxVkvYtc+2VjXlkj89J19qT0aOaQX0Zf5bc0CD+mKA3CyA==
X-Received: by 2002:a05:6214:1392:b0:690:d13a:3851 with SMTP id pp18-20020a056214139200b00690d13a3851mr5162275qvb.1.1710213860981;
        Mon, 11 Mar 2024 20:24:20 -0700 (PDT)
Received: from [10.5.0.2] ([91.196.69.182])
        by smtp.gmail.com with ESMTPSA id o8-20020a056214180800b0068ff79d8d97sm3267551qvw.41.2024.03.11.20.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 20:24:20 -0700 (PDT)
Message-ID: <7a26275f-7ed9-49a8-90ec-798f2f2de195@joelfernandes.org>
Date: Mon, 11 Mar 2024 23:24:15 -0400
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/30] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
 linux-kernel@vger.kernel.org, peterz@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, luto@kernel.org,
 bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org,
 mgorman@suse.de, jpoimboe@kernel.org, mark.rutland@arm.com, jgross@suse.com,
 andrew.cooper3@citrix.com, bristot@kernel.org,
 mathieu.desnoyers@efficios.com, geert@linux-m68k.org,
 glaubitz@physik.fu-berlin.de, anton.ivanov@cambridgegreys.com,
 mattst88@gmail.com, krypton@ulrich-teichert.org, rostedt@goodmis.org,
 David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
 jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, rcu@vger.kernel.org
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-16-ankur.a.arora@oracle.com>
 <20240310100330.GA2705505@joelbox2>
 <da51dacc-cdf7-4129-b424-b32764736f48@paulmck-laptop>
 <fd48ea5c-bc74-4914-a621-d12c9741c014@joelfernandes.org>
 <87r0ghl51f.fsf@oracle.com>
 <66820daa-421b-469a-a7e8-ae7ae9dfa978@joelfernandes.org>
 <87wmq8pop1.ffs@tglx>
 <5b78a338-cb82-4ac4-8004-77a3eb150604@joelfernandes.org>
 <87msr4f8cj.fsf@oracle.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <87msr4f8cj.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/2024 11:16 PM, Ankur Arora wrote:
> 
> Joel Fernandes <joel@joelfernandes.org> writes:
> 
>> Hi, Thomas,
>> Thanks for your reply! I replied below.
>>
>> On 3/11/2024 3:12 PM, Thomas Gleixner wrote:
>>> On Mon, Mar 11 2024 at 11:25, Joel Fernandes wrote:
> 
>    [ ... ]
> 
>>> What's wrong with the combination of PREEMPT_AUTO=y and PREEMPT_RCU=n?
>>> Paul and me agreed long ago that this needs to be supported.
>>
>> There's nothing wrong with it. Its just a bit quirky (again just a point of
>> view), that for a configuration that causes preemption (similar to
>> CONFIG_PREEMPT=y), that PREEMPT_RCU can be disabled. After all, again with
>> CONFIG_PREEMPT=y, PREEMPT_RCU cannot be currently disabled.
> 
> I think the argument was that PREEMPT_RCU=y is suboptimal for certain
> workloads, and those configurations might prefer the stronger
> forward-progress guarantees that PREEMPT_RCU=n provides.
> 
> See this:
> https://lore.kernel.org/lkml/73ecce1c-d321-4579-b892-13b1e0a0620a@paulmck-laptop/T/#m6aab5a6fd5f1fd4c3dc9282ce564e64f2fa6cdc3
> 
> and the surrounding thread.

Thanks for the link. Sorry for any noise due to being late to the party. Based
on the discussions, I concur with everyone on the goal of getting rid of
CONFIG_PREEMPT_DYNAMIC and the various cond_resched()/might_sleep() things. I'll
also go look harder at what else we need to get CONFIG_PREEMPT_RCU=y/n working
with CONFIG_PREEMPT_AUTO=y.

thanks,

- Joel
