Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB90368
	for <rcu@vger.kernel.org>; Mon, 12 Feb 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707697383; cv=none; b=apR6SJZg9XCXZzU5UKuSLS79Kzp/jeTJTgVTHADZdlxcG0+RS1wB/8yKJLbpe/sMY+bbtWx6fjTe4hOFYBnUwB56gCtJqPXqa92ql98s7CLbobO8E5UgELwo46m8NwlfnYBPhD/Qzh5ab5IuwqQ9FJPL9yauVLLgClR1T6ZZ8JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707697383; c=relaxed/simple;
	bh=KnOXg6DBWZL7YyahVVjU8bcEIFKzCTj3fGdcEoTKX7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YTfs+qrmcJHOcIr52QfD4OiypYcR/ywLQ86XySAyheGu4zPFeXv244CFk50dHnFBayG77s7wCGcV0A8VMVK/URvglon5yqqpGlZnbhOZoIbz11gNHWagUT1k6Kj992eoSVpmbD/YbfalK3rmWIhX5Ss4My5mhzUnTVpKA0ccILo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=R59Ne5ts; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R59Ne5ts"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-785d6172143so15047685a.1
        for <rcu@vger.kernel.org>; Sun, 11 Feb 2024 16:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707697380; x=1708302180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SETd6Pi33piXiIXtiEaIoJergf+0Mm/TiZVSgW7ZN6w=;
        b=R59Ne5tsh2lTJRH2DHess7k/MfW9I6A6JOKWDZ8JrLMgeJziTycnpA7QfRifWnEWLL
         MQkcLv1dB49NS0fMVeRuczjlmV7diL5AmIKte75uEjo+/a2F2twkXAVl6oUfkXOksedm
         PYg0dM/A0+zUhp3zUR4X6/j44tjx7SnqvO7so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707697380; x=1708302180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SETd6Pi33piXiIXtiEaIoJergf+0Mm/TiZVSgW7ZN6w=;
        b=CEJPQjUuWRwX9OuU+yekRGV8FoBhyBzTPGtdl9aD0uzmkde3bOyr0s3Kgwn1+QZ8+r
         iGTTuXrNRen3D247tzkHFn+iqniPtZFbKE/5qgghZARujg5gULvIM+B2NXZrAKHQuu0f
         BcTyafJTUwjdUIJOw07YJEmIS5gmCxdKxIoE6i5XKo2E3zPCj9FCKD1oja5SvdyxCBKH
         LjVnLbal3hO4RKSLyiR1xUiOP4g0t7Q38ShvhCnSa5rnCLEDevJbJXFJE0mKKfS4yqvJ
         3XheHnHKNE3UF70ml1B2S0yAuAwOT+2bmxVBWlgVB+olxiHb3lf8MF5etSYWSyYI7dom
         rs/A==
X-Gm-Message-State: AOJu0YwbLR1Tc4eR5DyfxPNPSP/jSlp7Pk32ykbGprd6AHlDqRR7LHjx
	2U6J3ii5eWjB6TLUiAvXRIi+Zj2ocONoZypUqnrevZ8YvZq4CPOcM+H6TtR2Bj0=
X-Google-Smtp-Source: AGHT+IFfnTLwLS3vadq38JMMZv1996HNQS4R3GWQr/FrT3Bi4hgO0HRV6D5uX+e5FwVUnIJyXXjy0w==
X-Received: by 2002:a05:620a:3888:b0:785:a3ce:5129 with SMTP id qp8-20020a05620a388800b00785a3ce5129mr4924322qkn.44.1707697380285;
        Sun, 11 Feb 2024 16:23:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVH0aq0ZfyIkB6XCtlh77JI0JR8tRTH/J4ItEUrmRQH3Q6sBTXjhiV0Zivy5un6g7LRIkttAcvqtgydmu3uBHk/vLRe+lTGnPmiL269kDIn7nAC3qtsr5N1H8ID5KVt/l/uCIJ7KLOt/ofVlOjNltKL+ncs9BhjEOWvw7w0DbSpLyKfEzGIrQ==
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id g5-20020a05620a40c500b00785cad6c218sm1219326qko.131.2024.02.11.16.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 16:22:59 -0800 (PST)
Message-ID: <29e6c22d-0487-42a5-b840-e3c7ea7c6270@joelfernandes.org>
Date: Sun, 11 Feb 2024 19:22:55 -0500
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Observation on NOHZ_FULL
Content-Language: en-US
To: Uladzislau Rezki <urezki@gmail.com>,
 Andrea Righi <andrea.righi@canonical.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org,
 "Cc: Frederic Weisbecker" <fweisbec@gmail.com>
References: <ZbjdL04k2Z2ZdUyp@gpd>
 <b8d80604-18a5-4f82-b846-5c00c6aeae6f@paulmck-laptop> <ZcJxhoNpkTM7LnOr@gpd>
 <9f9b6885-6d9d-4f30-9635-49443e1615e9@joelfernandes.org>
 <ZcOwRsEhbQhGv9X2@gpd>
 <CAEXW_YQN=Dm4TXv+F=Q4bfnKWn1Tv52=8hz50JLkbufcM5hUpQ@mail.gmail.com>
 <ZcO4c6nxemyxRFz3@gpd>
 <1fcf7e8a-c245-4c5c-ac86-7f0a1531032d@joelfernandes.org>
 <ZcR66cxax008lPGv@gpd> <ZcTO5lKeZoJZH1Mp@pc636> <ZcTqWiCJXg4H1wxp@pc636>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ZcTqWiCJXg4H1wxp@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/2024 9:51 AM, Uladzislau Rezki wrote:
> On Thu, Feb 08, 2024 at 01:53:58PM +0100, Uladzislau Rezki wrote:
>> On Thu, Feb 08, 2024 at 07:55:37AM +0100, Andrea Righi wrote:
>>> On Thu, Feb 08, 2024 at 12:54:58AM -0500, Joel Fernandes wrote:
>>> ...
>>>>>> Slightly related, but one of the things we are wondering also is how
>>>>>> much of the overhead for your nohz-full and lazy-RCU test (on top of
>>>>>> baseline - that is just CONFIG_HZ=1000 without nohz-full or nocbs) is
>>>>>> because of just using NOCB. Uladsizlau mentioned he might run a test
>>>>>> for comparing along those lines as well.
>>>>>
>>>>> Just to clarify, "lazy rcu on" results are just with rcu_nocb=all and
>>>>> lazy RCUs enabled (and HZ=1000), so without nohz_full.
>>>>>
>>>>> If I enable only nohz_full=all (without rcu_nocb) I see something like
>>>>> this:
>>>>
>>>> Ok. I did want to mention nohz_full implies rcu_nocb on the same CPUs as well.
>>>>
>>>> Its also mentioned in the boot param docs on the last line of the description:
>>>>
>>>>         nohz_full=      [KNL,BOOT,SMP,ISOL]
>>>>                         The argument is a cpu list, as described above.
>>>>                         In kernels built with CONFIG_NO_HZ_FULL=y, set
>>>>                         the specified list of CPUs whose tick will be stopped
>>>>                         whenever possible. The boot CPU will be forced outside
>>>>                         the range to maintain the timekeeping.  Any CPUs
>>>>                         in this list will have their RCU callbacks offloaded,
>>>>                         just as if they had also been called out in the
>>>>                         rcu_nocbs= boot parameter.
>>>
>>> Ah I didn't realize that, it definitely makes sense, thanks for
>>> clarifying it.
>>>
>>> Then basically in the results that I posted the difference is
>>> "nohz_full=all+rcu_nocb=all" vs "rcu_nocb=all+lazy_RCU=on".
>>>
>> So, you say that a hrtimer_interrupt() handler takes more time in case
>> of lazy + nocb + rcu_nocb=all and for nohz_full + rcu_nocb=all it faster?
>> Could you please clarify this? I will try to measure from my side!
>>
>> I have done some basic research about hrtimer_interrupt() latency on my
>> HW with latest Linux kernel. I have compared below cases:
>>
>> case a: 1000HZ + lazy + nocb_all_cpus
>> case b: 1000HZ + nocb_all_cpus
>>
>> I used "ftrace" to measure time(in microseconds). Steps:
>>
>> echo 0 > tracing_on
>> echo function_graph > current_tracer
>> echo funcgraph-proc > trace_options
>> echo funcgraph-abstime > trace_options
>> echo hrtimer_interrupt > set_ftrace_filter
>>
>> fio --rw=write --bs=1M --size=1G --numjobs=8 --name=worker --time_based --runtime=50&
>>
>> echo 1 > tracing_on; sleep 10; echo 0 > tracing_on
>>
>> data is based on 10 seconds collection:
>>
>> <case a>
>>      6  2102 ############################################################
>>      8  2079 ############################################################
>>     10  1464 ##########################################
>>      7   897 ##########################

So first column is microseconds and second one is count?

>>      9   625 ##################
>>     12   490 ##############
>>     13   479 ##############
>>     11   289 #########
>>      5   249 ########
>>     14   124 ####
>>     15    72 ###
>>     16    41 ##
>>     17    24 #
>>      4    22 #
>>     18    12 #
>>     22     2 #
>>     19     1 #
>> <case a>
>>
>> <case b>
>>      9  1658 ############################################################
>>     13  1308 ################################################
>>     12  1224 #############################################

Assuming that, it does seem the "best" case is off by 3 microseconds (9 vs 6),
still would not warrant being regarded a bug and possibly just in the noise.

>>     10   972 ####################################
>>      8   703 ##########################
>>     14   595 ######################
>>     15   571 #####################
>>     11   525 ###################
>>     17   350 #############
>>     16   235 #########
>>      7   214 ########
>>      4    73 ###
>>      5    68 ###
>>      6    54 ##
>>     20     9 #
>>     18     9 #
>>     19     6 #
>>     33     1 #
>>      3     1 #
>>     28     1 #
>>     27     1 #
>>     25     1 #
>>     22     1 #
>>     21     1 #
>> <case b>
>>
>> I do not see the difference, there is a nose of 1/2/3 microseconds diff.
>>
> Let me further have a look at what we use for lazy in terms on hrtimer though.

Thanks for tracing it. Yeah it would be nice to count how many counts of
do_nocb_deferred_wakeup() does the fio test trigger. If it is few, then maybe
the problem with hrtimer_interrupt() is something else.

 - Joel

