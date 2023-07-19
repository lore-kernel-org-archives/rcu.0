Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2551EB64DA
	for <rcu@archiver.kernel.org>; Wed, 19 Jul 2023 11:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbjGSLwF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 19 Jul 2023 07:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjGSLwD (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 19 Jul 2023 07:52:03 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631A911B
        for <rcu@vger.kernel.org>; Wed, 19 Jul 2023 04:52:01 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7659c6cae2cso460780785a.1
        for <rcu@vger.kernel.org>; Wed, 19 Jul 2023 04:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1689767520; x=1692359520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CQ51DqXnBkZV20qyGIq5WlkmAAtxCH+iOBfKBuzqws4=;
        b=NpCaE0RVwBfwhBRCtkm6Wz2nLaJ38NRPC37jTs/6NDu1hKJfcOkFo+wnLIi8kakdJP
         UDjGJg+vj3F1hWYvAcyxlT/GADL+Es5lw52BKjt+TMy7D97g7co1LDfGceu6TmvDVjTj
         bWoLzR3TmjTc5Qj313+nRFjaLFn+zgmNf8pt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689767520; x=1692359520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CQ51DqXnBkZV20qyGIq5WlkmAAtxCH+iOBfKBuzqws4=;
        b=RibzCsA1egevtpl2pmsnNWFwJPs3IA4McH3EPqrHBfhqNiV+OgwLFvzNdFTwBWpC7J
         LzmrQA0vEoOiazaDk9lhyp/hDGJ014nwn4nxVX9WQuxkgvnOB2w5sX4Rd8+fFnaIO9/R
         BHxTnm/szQ8q5vqzOkyLv8xIK67mLNnw6u+bXpDRIAeb2Hj7gdl/LkdZ0cmY61ljxPVc
         ZMc8jDm9GsA2/dMnZNaHXR2TlRslp8HGCYGLQjsqGuTwWsI1aelicHgYmnPIxQ3ddvCZ
         fxr5VRUKmn2n4OXc/+Pvx0QQxFgq64jrOYLnyCYwpk9Sl2qJbzAq4FQGWBzqlspvccvF
         P70Q==
X-Gm-Message-State: ABy/qLZd9EtLSSswfaMN+wYATXB17Iq14njbLXfiMp1IsCyr/8TAd/Cq
        zfT+cSYm7iBL+1UrJCmTxJUI8g==
X-Google-Smtp-Source: APBJJlGwesG3yuMa1fWVA6ume80PY+SCQJgp1ByEPg7SYmYqelgStBp+RrzF0MrH3mmOCIo0SfIpfQ==
X-Received: by 2002:a05:620a:6783:b0:765:35ec:5ff7 with SMTP id rr3-20020a05620a678300b0076535ec5ff7mr1963550qkn.20.1689767520447;
        Wed, 19 Jul 2023 04:52:00 -0700 (PDT)
Received: from [192.168.0.198] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id f21-20020ae9ea15000000b00767b37256ecsm1195782qkg.107.2023.07.19.04.51.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 04:51:59 -0700 (PDT)
Message-ID: <a0f6e131-a649-1731-b096-46313a0460a9@joelfernandes.org>
Date:   Wed, 19 Jul 2023 07:51:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH rcu 5/5] checkpatch: Complain about unexpected uses of RCU
 Tasks Trace
Content-Language: en-US
To:     paulmck@kernel.org, Joe Perches <joe@perches.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
References: <a6fff63c-5930-4918-82a3-a9301309d88d@paulmck-laptop>
 <20230717180454.1097714-5-paulmck@kernel.org>
 <04e74fd214a01bee0fb5ac690730cb386536cced.camel@perches.com>
 <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <8477fd32-38a5-4d66-8deb-a61b0e290df5@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 7/17/23 19:34, Paul E. McKenney wrote:
> On Mon, Jul 17, 2023 at 03:34:14PM -0700, Joe Perches wrote:
>> On Mon, 2023-07-17 at 11:04 -0700, Paul E. McKenney wrote:
>>> RCU Tasks Trace is quite specialized, having been created specifically
>>> for sleepable BPF programs.  Because it allows general blocking within
>>> readers, any new use of RCU Tasks Trace must take current use cases into
>>> account.  Therefore, update checkpatch.pl to complain about use of any of
>>> the RCU Tasks Trace API members outside of BPF and outside of RCU itself.
>>>
>>> Cc: Andy Whitcroft <apw@canonical.com> (maintainer:CHECKPATCH)
>>> Cc: Joe Perches <joe@perches.com> (maintainer:CHECKPATCH)
>>> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com> (reviewer:CHECKPATCH)
>>> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>> Cc: <bpf@vger.kernel.org>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>   scripts/checkpatch.pl | 18 ++++++++++++++++++
>>>   1 file changed, 18 insertions(+)
>>>
>>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>>> @@ -7457,6 +7457,24 @@ sub process {
>>>   			}
>>>   		}
>>>   
>>> +# Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
>>> +		if ($line =~ /\brcu_read_lock_trace\s*\(/ ||
>>> +		    $line =~ /\brcu_read_lock_trace_held\s*\(/ ||
>>> +		    $line =~ /\brcu_read_unlock_trace\s*\(/ ||
>>> +		    $line =~ /\bcall_rcu_tasks_trace\s*\(/ ||
>>> +		    $line =~ /\bsynchronize_rcu_tasks_trace\s*\(/ ||
>>> +		    $line =~ /\brcu_barrier_tasks_trace\s*\(/ ||
>>> +		    $line =~ /\brcu_request_urgent_qs_task\s*\(/) {
>>> +			if ($realfile !~ m@^kernel/bpf@ &&
>>> +			    $realfile !~ m@^include/linux/bpf@ &&
>>> +			    $realfile !~ m@^net/bpf@ &&
>>> +			    $realfile !~ m@^kernel/rcu@ &&
>>> +			    $realfile !~ m@^include/linux/rcu@) {
>>
>> Functions and paths like these tend to be accreted.
>>
>> Please use a variable or 2 like:
>>
>> our $rcu_trace_funcs = qr{(?x:
>> 	rcu_read_lock_trace |
>> 	rcu_read_lock_trace_held |
>> 	rcu_read_unlock_trace |
>> 	call_rcu_tasks_trace |
>> 	synchronize_rcu_tasks_trace |
>> 	rcu_barrier_tasks_trace |
>> 	rcu_request_urgent_qs_task
>> )};
>> our $rcu_trace_paths = qr{(?x:
>> 	kernel/bfp/ |
>> 	include/linux/bpf |
>> 	net/bpf/ |
>> 	kernel/rcu/ |
>> 	include/linux/rcu
>> )};
> 
> Like this?
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		our $rcu_trace_paths = qr{(?x:
> 			kernel/bfp/ |
> 			include/linux/bpf |
> 			net/bpf/ |
> 			kernel/rcu/ |
> 			include/linux/rcu
> 		)};
> 		if ($line =~ /$rcu_trace_funcs/) {
> 			if ($realfile !~ m@^$rcu_trace_paths@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> No, that is definitely wrong.  It has lost track of the list of pathnames,
> thus complaining about uses of those functions in files where their use
> is permitted.
> 
> But this seems to work:
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> 			if ($realfile !~ m@^kernel/bpf@ &&
> 			    $realfile !~ m@^include/linux/bpf@ &&
> 			    $realfile !~ m@^net/bpf@ &&
> 			    $realfile !~ m@^kernel/rcu@ &&
> 			    $realfile !~ m@^include/linux/rcu@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> Maybe the "^" needs to be distributed into $rcu_trace_paths?
> 
> # Complain about RCU Tasks Trace used outside of BPF (and of course, RCU).
> 		our $rcu_trace_funcs = qr{(?x:
> 			rcu_read_lock_trace |
> 			rcu_read_lock_trace_held |
> 			rcu_read_unlock_trace |
> 			call_rcu_tasks_trace |
> 			synchronize_rcu_tasks_trace |
> 			rcu_barrier_tasks_trace |
> 			rcu_request_urgent_qs_task
> 		)};
> 		our $rcu_trace_paths = qr{(?x:
> 			^kernel/bfp/ |
> 			^include/linux/bpf |
> 			^net/bpf/ |
> 			^kernel/rcu/ |
> 			^include/linux/rcu
> 		)};
> 		if ($line =~ /\b$rcu_trace_funcs\s*\(/) {
> 			if ($realfile !~ m@$rcu_trace_paths@) {
> 				WARN("RCU_TASKS_TRACE",
> 				     "use of RCU tasks trace is incorrect outside BPF or core RCU code\n" . $herecurr);
> 			}
> 		}
> 
> But no joy here, either.  Which is no surprise, given that perl is
> happy to distribute the "\b" and the "\s*\(" across the elements of
> $rcu_trace_funcs.  I tried a number of other variations, including
> inverting the "if" condition "(!(... =~ ...))", inverting the "if"
> condition via an empty "then" clause, replacing the "m@" with "/",
> replacing the "|" in the "qr{}" with "&", and a few others.
> 
> Again, listing the pathnames explicitly in the second "if" condition
> works just fine.
> 

Not a perl expert but I wonder if the following are any options at all:

1. Instead of having a complex list of strings in a regex variable, it 
might be easier to hold the strings as a perl array, and then iterate 
over that array checking each element of the array on every iteration, 
against the line.

2. Roll the "\b" and/or "^" in into the regex variable itself than 
trying make them play with the variable later.

3. Use parentheses around the variable? Not sure if that will work but I 
wonder if it has something to do with operator precedence.

4. Instead of a list of paths, maybe it is better to look for "rcu" or 
"bpf" in the regex itself? That way new paths don't require script 
updates (at the expense though of false-positives (highly unlikely, IMHO)).

thanks,

- Joel
