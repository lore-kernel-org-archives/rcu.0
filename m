Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A6261B9D
	for <rcu@vger.kernel.org>; Fri,  5 Dec 2025 14:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764944589; cv=none; b=YTpvw3UkzzfxmzoMLS4o57mfDU7gPNkrXzr05Tk6aeuA1ddcIai9s/eqxee92+rfV76QZZUHlFKGX0Jl6seke1NzQuUmSxSPvrRmh4lQN4aK9tliZXCTgae2RnjV8u/xW94Xi7gQDjJXjrzs0TpbiDiFafNn4vG0rQYJCw0Ybns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764944589; c=relaxed/simple;
	bh=6MKiPhJcrIDmFvToeHGHOU5EdVuBUrEFRkhJF7eizow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SGBBmtn77p424NIrgARbhHzGj9UoJDFalKlb6Y08yEdFI7Grn4CPCpEK9PrTTzNiLHHMCWA6xetq9KsNr/Xlh/VuNakqtN2goxYWyhStr6XvfESRZMdZyYFeGE3Wo/+0v9zpOP3+UMYwoi8zBFfvdqxL/ZD3tlMsf3l5iqxH5E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lyGD5TMd; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lyGD5TMd"
Message-ID: <823f79bc-12f0-445b-b7f3-49bce8b2b7b1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764944582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVptvmKSGEtn7xodnm1nBxceKRAxfL7S0TOt52fPMYM=;
	b=lyGD5TMdFnOWYn+X61t1NdbuiK4+TbRdVdT8S29ix2k8rZ5jplugBj3NDVoXZt/98eMSBm
	8t76I79LJUFhvEetglSPLv//qLOzD2iN8XvgCXBnBMRrWg3qR7UwZI/PZf/Gfq4jwhnCJ1
	JgK4tfTeqYRdn/pjsX+Re4C+BoL4d20=
Date: Fri, 5 Dec 2025 22:22:00 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rcu: Improve comments for RCU_FANOUT and RCU_FANOUT_LEAF
To: paulmck@kernel.org
Cc: frederic@kernel.org, neeraj.upadhyay@kernel.org, joelagnelf@nvidia.com,
 josh@joshtriplett.org, boqun.feng@gmail.com, urezki@gmail.com,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
 qiang.zhang@linux.dev, rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 Kunwu Chan <chentao@kylinos.cn>
References: <20251023032742.2850029-1-kunwu.chan@linux.dev>
 <f2ca1650-0bbc-48fb-a6d9-6c4313325a1a@paulmck-laptop>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kunwu Chan <kunwu.chan@linux.dev>
In-Reply-To: <f2ca1650-0bbc-48fb-a6d9-6c4313325a1a@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/30/25 07:46, Paul E. McKenney wrote:
> On Thu, Oct 23, 2025 at 11:27:42AM +0800, Kunwu Chan wrote:
>> From: Kunwu Chan <chentao@kylinos.cn>
>>
>> The original comments introduced in commit 05c5df31afd1
>> ("rcu: Make RCU able to tolerate undefined CONFIG_RCU_FANOUT"),
>> contained confusing annotations.
>>
>> Specifically, the #else and #endif comments did not clearly reflect
>> their corresponding condition blocks, hampering readability.
>>
>> Fixes condition branch comments. And adds explicit explanations of
>> the overall purpose:
>> defining middle/leaf fan-out parameters, their relation to Kconfig,
>> and how they shape the RCU hierarchy based on CPU count.
>>
>> Make the hierarchical configuration logic of the RCU easier to understand.
>>
>> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> Thank you for posting this!  Please see below for some comments.
>
> 							Thanx, Paul
>
>> ---
>>   include/linux/rcu_node_tree.h | 16 ++++++++++++----
>>   1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/rcu_node_tree.h b/include/linux/rcu_node_tree.h
>> index 78feb8ba7358..b03c0ce91dec 100644
>> --- a/include/linux/rcu_node_tree.h
>> +++ b/include/linux/rcu_node_tree.h
>> @@ -25,26 +25,34 @@
>>   /*
>>    * Define shape of hierarchy based on NR_CPUS, CONFIG_RCU_FANOUT, and
>>    * CONFIG_RCU_FANOUT_LEAF.
>> + * - RCU_FANOUT: Controls fan-out of middle levels in the RCU hierarchy.
>> + * - RCU_FANOUT_LEAF: Controls fan-out of the leaf level (directly managing CPUs).
>> + *
>> + * These parameters are determined by Kconfig options if configured; otherwise,
>> + * they use sensible defaults based on system architecture (for RCU_FANOUT)
>> + * or a fixed default (for RCU_FANOUT_LEAF).
> I have no objections to this change if at least one of my fellow
> maintainers is willing to speak up for it and none of the others object
> to it.
>
>>    * In theory, it should be possible to add more levels straightforwardly.
>>    * In practice, this did work well going from three levels to four.
>>    * Of course, your mileage may vary.
>>    */
>>   
>> +/* Define RCU_FANOUT: middle-level fan-out parameter */
>>   #ifdef CONFIG_RCU_FANOUT
>>   #define RCU_FANOUT CONFIG_RCU_FANOUT
>> -#else /* #ifdef CONFIG_RCU_FANOUT */
>> +#else /* #ifndef CONFIG_RCU_FANOUT */
>>   # ifdef CONFIG_64BIT
>>   # define RCU_FANOUT 64
>>   # else
>>   # define RCU_FANOUT 32
>>   # endif
>> -#endif /* #else #ifdef CONFIG_RCU_FANOUT */
>> +#endif
>>   
>> +/* Define RCU_FANOUT_LEAF: leaf-level fan-out parameter (manages CPUs directly) */
>>   #ifdef CONFIG_RCU_FANOUT_LEAF
>>   #define RCU_FANOUT_LEAF CONFIG_RCU_FANOUT_LEAF
>> -#else /* #ifdef CONFIG_RCU_FANOUT_LEAF */
>> +#else /* #ifndef CONFIG_RCU_FANOUT_LEAF */
>>   #define RCU_FANOUT_LEAF 16
>> -#endif /* #else #ifdef CONFIG_RCU_FANOUT_LEAF */
>> +#endif
> But these much stay as they are.  The #else echos the "#if" condition, and
> the #endif contains "#else" followed by the "#if" condition.  This means
> that you can tell where you are without having to find the matching "#if"
> and without having to figure out whether there is an intervening "#else".

Hi Paul,

Thank you for the feedback! I reviewed 
Documentation/process/coding-style.rst and
found the guidance on #endif comments (section 19), but I didn't find 
explicit
guidance on the #else comment format. I wasn't aware of the specific 
convention
used in the RCU codebase for #else and #endif directives. I understand 
now that
this format helps readers quickly identify which conditional branch 
they're in
without having to search backwards for the matching #if.

I'll prepare a V2 patch that restores the original #else and #endif 
comment format
while keeping the new explanatory comments about RCU_FANOUT and 
RCU_FANOUT_LEAF.

>
>>   #define RCU_FANOUT_1	      (RCU_FANOUT_LEAF)
>>   #define RCU_FANOUT_2	      (RCU_FANOUT_1 * RCU_FANOUT)
>> -- 
>> 2.25.1
>>
-- 
Thanks,
        Kunwu Chan.

