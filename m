Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.12.242.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794169293;
	b=QRSQEJTpiN0NM5m+7hoRNXNJ0KdLlaf/Dmo8dDyagVXX7oNILJ3CqlNeGM2bfN//Tfa+
	 VMMz0vX2zQ5q8THicUSIB+jF3mqqncnKbZWSV2YkBKCbMnbxXnwahw0rSEe9j3FLK3m6i
	 hh7dvTb93b4Atyz1uud1oT2bL86F5a27phW7s4n3BfdSVMHffLgKkq9B5wcguwamLmZT7
	 64xOWknp1Us/AJuiqaw3v4co26JVYh4TArZ9zTaQXe/+q2UWWDvSphuP+5oWOnHumMQYG
	 N91jxwg3n4lD6djSJBrwgQ+5Yqwe90zsvRitaa6qPMQz+hrGSC7tEoSw/wvvCbC4D4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794169293;
	h=DMARC-Filter:Received:DKIM-Signature:X-ME-Helo:X-ME-Auth:X-ME-Date:
	 X-ME-IP:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=a/M0V+byVIm73dyVpHMJqTVDVYyUZQSmRt8kOhb0YSM=;
	b=12aXKBWCNaM9Mhpik+GOx8Iu6PwKGjPKYmpw1QypETEv1dWz4AqQzV3EqX4PXXBGs8ko
	 b5YrtE+sjsJBYGgYu1X+/PQVfCwCWxsh3WhbGr3BcgM2CBRR23E9ZGeEj9F6gNOCl4K77
	 3uNwo7K1XYWPbGicZZhL5t/H2YllaSLnvjOCq0KIu4FgamJZt/zapR6jaM8Pqsu3I1UuE
	 AnRsgzmEmo21aEPIPY0J/ueiZvxJvHEpJiEGMl9gRBhIyNezMMa3g1ymoYxDChI2MVNQ4
	 h97Qm6RZozUR0ga38weLZzbHA/UkUbky5CqRSG1fI0HRQnmZQ3gXO6DZiRM3zIZd+0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wanadoo.fr;
	spf=pass smtp.mailfrom=wanadoo.fr;
	dkim=pass header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b="NZ7NabX/";
	arc=none smtp.remote-ip=80.12.242.19
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF5C606A31C;
	Sun,  8 Nov 2026 20:21:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FF5C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=NZ7NabX/
Received: from [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
 ([IPv6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e])
	by smtp.orange.fr with ESMTPSA
	id Q9OBxTqORbyBrQ9OBxd3pl; Sun, 08 Nov 2026 21:21:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1794169283;
	bh=a/M0V+byVIm73dyVpHMJqTVDVYyUZQSmRt8kOhb0YSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=NZ7NabX/Em2A5BOCVDv6wTpym4WtPWldbEh7Pzo2dsrDrLM7ibcF7MEGEtcMQ2VK2
	 8KN7z/fEgGm+XrAGOFC7DpVSQ9iqBtG5lngz0kWy/nHjB1rLCDuP7pEX1LXmdtz2c9
	 INShME3jdG38rLiZKvmrx+S7L97iBA8FYoIk7gt/L8PHoTRTMVPDo3QhqY1J7OpM+V
	 Vs38vvtb3hNGjqUo0Ff1vzzeaAdupcNgzkpj77ZYNGXlu8qK33ynEjdBwxadzRSZ8I
	 8ipcRc0RYblVSNY4RYZfZZJtR42RB3kHuWni6DJWPvAsoBUQpzNLLW8o3KMSI5yDFn
	 nekfKiueg5gAg==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:26fb:aefb:6cd2:db0e]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 08 Nov 2026 21:21:23 +0100
X-ME-IP: 2a01:cb10:785:b00:26fb:aefb:6cd2:db0e
Message-ID: <afaf8aa9-f7e3-4fc7-9e4e-7b9e9c73ca5f@wanadoo.fr>
Date: Sun, 8 Nov 2026 21:21:18 +0100
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
Subject: Re: [PATCH] rcuscale: Constify struct rcu_scale_ops
To: Bradley Morgan <brads@mainlining.org>
Cc: boqun@kernel.org, dave@stgolabs.net, frederic@kernel.org,
 jiangshanlai@gmail.com, joelagnelf@nvidia.com, josh@joshtriplett.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, neeraj.upadhyay@kernel.org,
 paulmck@kernel.org, qiang.zhang@linux.dev, rcu@vger.kernel.org,
 rostedt@goodmis.org, urezki@gmail.com
References: <3f546f8e102ef271e7d5ac6d8b6a1f44d0fb20cb.1794085327.git.christophe.jaillet@wanadoo.fr>
 <B33D74A6-E196-45F4-AA77-32B4FDCD0817@mainlining.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <B33D74A6-E196-45F4-AA77-32B4FDCD0817@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/11/2026 à 00:25, Bradley Morgan a écrit :
> On 7 November 2026 21:02:25 GMT, Christophe JAILLET
> <christophe.jaillet@wanadoo.fr> wrote:
>> 'struct rcu_scale_ops' is not modified in this driver.
>>
>> Constifying these structures moves some data to a read-only section, so
>> increases overall security, especially when the structure holds some
>> function pointers.
>>
>> On a x86_64, with allmodconfig:
>> Before:
>> ======
>>    text	   data	    bss	    dec	    hex	filename
>>   45585	  24946	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>>
>> After:
>> =====
>>    text	   data	    bss	    dec	    hex	filename
>>   46545	  23986	   2816	  73347	  11e83	kernel/rcu/rcuscale.o
>>
> 
> Well, thanks. so you just consted rcu_scale_ops()? Uhh, well, this makes
> enough sense to be feasible
> 
> Reviewed-by: Bradley Morgan
> <brads@mainlining.org>
> 
> But how is this worth it? Why doesn't this work now? how will this make it
> better? Those are my questions.

Nut sure to fully understand your point.

- how is this worth it?
The patch is simple and easy to review.
The struct rcu_scale_ops is local to this file, so no side effect is 
expected. It is compile tested.
So the additional security it brings (some function pointers that are 
now read-only) is a win to nearly no cost.

- Why doesn't this work now?
It does work now. The patch is not a fix, just an improvement.

-how will this make it better?
The function pointers that are now read-only can't be modified. So the 
code is safer.
A modification could be done by a bug that writes memory at an 
unexpected location or by an attacker that would manage to overwrite 
these function pointers to change the behavior of the code.
In general, RO data is preferred to RW when possible.

Hoping this answers your question.

CJ

> 
> Well, I'm shrugging, but my tag would stand here, because it won't break
> anything in particular.
> 
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>> ---
>> kernel/rcu/rcuscale.c | 18 +++++++++---------
>> 1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
>> index 1097ec15879c..522f7bc2e693 100644
>> --- a/kernel/rcu/rcuscale.c
>> +++ b/kernel/rcu/rcuscale.c
>> @@ -159,7 +159,7 @@ struct rcu_scale_ops {
>> 	const char *name;
>> };
>>
>> -static struct rcu_scale_ops *cur_ops;
>> +static const struct rcu_scale_ops *cur_ops;
>>
>> /*
>>   * Definitions for rcu scalability testing.
>> @@ -185,7 +185,7 @@ static void rcu_sync_scale_init(void)
>> {
>> }
>>
>> -static struct rcu_scale_ops rcu_ops = {
>> +static const struct rcu_scale_ops rcu_ops = {
>> 	.ptype		= RCU_FLAVOR,
>> 	.init		= rcu_sync_scale_init,
>> 	.readlock	= rcu_scale_read_lock,
>> @@ -247,7 +247,7 @@ static void srcu_scale_synchronize_expedited(void)
>> 	synchronize_srcu_expedited(srcu_ctlp);
>> }
>>
>> -static struct rcu_scale_ops srcu_ops = {
>> +static const struct rcu_scale_ops srcu_ops = {
>> 	.ptype		= SRCU_FLAVOR,
>> 	.init		= rcu_sync_scale_init,
>> 	.readlock	= srcu_scale_read_lock,
>> @@ -276,7 +276,7 @@ static void srcu_sync_scale_cleanup(void)
>> 	cleanup_srcu_struct(srcu_ctlp);
>> }
>>
>> -static struct rcu_scale_ops srcud_ops = {
>> +static const struct rcu_scale_ops srcud_ops = {
>> 	.ptype		= SRCU_FLAVOR,
>> 	.init		= srcu_sync_scale_init,
>> 	.cleanup	= srcu_sync_scale_cleanup,
>> @@ -313,7 +313,7 @@ static void rcu_tasks_scale_stats(void)
>> 	rcu_tasks_torture_stats_print(scale_type, SCALE_FLAG);
>> }
>>
>> -static struct rcu_scale_ops tasks_ops = {
>> +static const struct rcu_scale_ops tasks_ops = {
>> 	.ptype		= RCU_TASKS_FLAVOR,
>> 	.init		= rcu_sync_scale_init,
>> 	.readlock	= tasks_scale_read_lock,
>> @@ -357,7 +357,7 @@ static void rcu_tasks_rude_scale_stats(void)
>> 	rcu_tasks_rude_torture_stats_print(scale_type, SCALE_FLAG);
>> }
>>
>> -static struct rcu_scale_ops tasks_rude_ops = {
>> +static const struct rcu_scale_ops tasks_rude_ops = {
>> 	.ptype		= RCU_TASKS_RUDE_FLAVOR,
>> 	.init		= rcu_sync_scale_init,
>> 	.readlock	= tasks_rude_scale_read_lock,
>> @@ -396,7 +396,7 @@ static void tasks_trace_scale_read_unlock(int idx)
>> 	rcu_read_unlock_trace();
>> }
>>
>> -static struct rcu_scale_ops tasks_tracing_ops = {
>> +static const struct rcu_scale_ops tasks_tracing_ops = {
>> 	.ptype		= RCU_TASKS_FLAVOR,
>> 	.init		= rcu_sync_scale_init,
>> 	.readlock	= tasks_trace_scale_read_lock,
>> @@ -693,7 +693,7 @@ rcu_scale_writer(void *arg)
>> }
>>
>> static void
>> -rcu_scale_print_module_parms(struct rcu_scale_ops *cur_ops, const char *tag)
>> +rcu_scale_print_module_parms(const struct rcu_scale_ops *cur_ops, const char *tag)
>> {
>> 	pr_alert("%s" SCALE_FLAG
>> 		 "--- %s: gp_async=%d gp_async_max=%d gp_exp=%d holdoff=%d minruntime=%d nreaders=%d nwriters=%d nexp=%d exp_interval=%d writer_holdoff=%d writer_holdoff_jiffies=%d verbose=%d shutdown_secs=%d\n",
>> @@ -1109,7 +1109,7 @@ rcu_scale_init(void)
>> 	int firsterr = 0;
>> 	long i;
>> 	long j;
>> -	static struct rcu_scale_ops *scale_ops[] = {
>> +	static const struct rcu_scale_ops *scale_ops[] = {
>> 		&rcu_ops, &srcu_ops, &srcud_ops, TASKS_OPS TASKS_RUDE_OPS TASKS_TRACING_OPS
>> 	};
>>
>>
> 
> --- Thanks!

