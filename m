Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DF53C9EDD;
	Sat, 17 Oct 2026 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260089; cv=none; b=kDcuhYDqbAqqbZ5duwXXcq1hLI2UBcDcOcMbC2nZRCqGSSkShhottV5DumjlKBaCk7UhKLV/dQcFz6yb3HaDg/WvNwv4/5ZvnfqJCO7NHci+0oiaj5lw/h9cTpZ99jjnyH8YXZcXj/5OpXs6QZE0j2Tv4OMfWNxOQkpu3TfCiwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260089; c=relaxed/simple;
	bh=+c/xiDUPku8W1vKWQKXvJWMOO4RfbpagwfgQcUwn2Tw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pBWkHdAbUvvtSKXll43zob745lYVw76FWR2NWMhbIOWF0sYCLl71EUSZPqGbqDhjoGw3A6rKv9/aFSgccRJrmaBKRLq4ILD/N2clh7jRMNGMMRofURaA9niacXsDD1xAmlfWnqQB316Iv9apfF/LRScsgb1aHQ2R7KIaiKETEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=Pwiurlty; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=qtZfeDdH; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Pwiurlty";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="qtZfeDdH"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792260058; bh=vQzXdR/kzJROk3+hTFbRUPZ
	YUiSuUSMMqSOAjMeiBoU=; b=PwiurltyKMpllS8kXgGsYj50jhHudSeBkVv6x57sW085UJVCde
	QTGqPOGgNyi1wCOheBFPPLXplBiKoHLUiM2nDr4bkjKNyoQkex2L92qNmpUFQd6tAzIRKRCmx+J
	pJeFOl5SebQ1dMFX77CkcvLm0V8BmqjTP2CNj4dNKu+Wt7S1X9FhpJ+WaAuEoPPr75Ss8quhGqg
	Z7UNvfRWFge46omvXfG+OboTH3S9N2fFCKs4RIqcMtorsimlMopyDuFJ2BGoHioGV691J70UCfM
	e6SmnVEzP9sL2R1PMJTwuAIg8pUNP6PZqetL0EKziyW7z1mIArGU4V6ZejVAfeWH4mg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1792260058; bh=vQzXdR/kzJROk3+hTFbRUPZ
	YUiSuUSMMqSOAjMeiBoU=; b=qtZfeDdHTawoBojwHT2w2U035c5Vap7ZJiKHFNX4a56QlXO2+p
	kX/Jr/IxaMttuV5d0erC1jzsOlp7RfBV3+Cw==;
Date: Sat, 17 Oct 2026 19:00:58 +0100
From: Bradley Morgan <brads@mainlining.org>
To: paulmck@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>
CC: qiang.zhang@linux.dev, frederic@kernel.org, neeraj.upadhyay@kernel.org,
 joelagnelf@nvidia.com, josh@joshtriplett.org, boqun@kernel.org,
 urezki@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 jiangshanlai@gmail.com, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_rcu/tasks=3A_Use_static_per_cpu?=
 =?US-ASCII?Q?_work=5Fstruct_for_Tasks_Rude_grace_periods?=
In-Reply-To: <4b456047-62ae-4bc2-8da5-e4e5e603fcbb@paulmck-laptop>
References: <20261017123313.1441679-1-brads@mainlining.org> <4b456047-62ae-4bc2-8da5-e4e5e603fcbb@paulmck-laptop>
Message-ID: <16D9B60F-5D06-45F0-9414-553BF9CF2540@mainlining.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 17 October 2026 18:55:37 BST, "Paul E. McKenney" <paulmck@kernel.org>
wrote:
>On Sat, Oct 17, 2026 at 12:33:13PM +0000, Bradley Morgan wrote:
>> Zqiang caught a snafu in the rude grace period, if a too small grace
>> period was reached, a UAF could occur. However, his patch used
>> a WARN_ONCE() on schedule_on_each_cpu() OOM failures, which would not
>> have handled the failure properly.
>> 
>> Instead of throwing a warning or relying on dynamic alloc_percpu(),
>replace
>> the dynamic allocation with static per cpu work_struct instances. Using
>> schedule_work_on() and flush_work() keeps everything in task context,
>> guarantees the required context switch on every online CPU, and stays
>> zero allocation so it cannot fail under OOM.
>> 
>> Suggested-by: Zqiang <qiang.zhang@linux.dev>
>> Signed-off-by: Bradley Morgan <brads@mainlining.org>
>
>Sorry, Bradley, but no, absolutely not.
>
>Because this not taking a suggestion, but is instead *exactly* Zqiang's
>patch.  We do not commit plagiarism in the Linux-kernel community.
>
>Zqiang, please submit a proper patch with appropriate credit to Bradley.
>The obvious approach would be to following his example, that is, to
>credit him using Suggested-by, but Reported-by or a sentence calling out
>his feedback in the commit log would suffice.  However, I will defer to
>your best judgment.

Apologies, I must've misunderstood..
:(

>
>							Thanx, Paul
>
>> ---
>>  kernel/rcu/tasks.h | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>> 
>> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
>> index 627295396cd9..f81c0ea0b92a 100644
>> --- a/kernel/rcu/tasks.h
>> +++ b/kernel/rcu/tasks.h
>> @@ -1348,11 +1348,25 @@ static void rcu_tasks_be_rude(struct work_struct
>*work)
>>  {
>>  }
>>  
>> +static DEFINE_PER_CPU(struct work_struct, tasks_rude_work);
>> +
>>  // Wait for one rude RCU-tasks grace period.
>>  static void rcu_tasks_rude_wait_gp(struct rcu_tasks *rtp)
>>  {
>> +	int cpu;
>> +
>> +	guard(cpus_read_lock)();
>>  	rtp->n_ipis += cpumask_weight(cpu_online_mask);
>> -	schedule_on_each_cpu(rcu_tasks_be_rude);
>> +
>> +	for_each_online_cpu(cpu) {
>> +		struct work_struct *work = &per_cpu(tasks_rude_work, cpu);
>> +
>> +		INIT_WORK(work, rcu_tasks_be_rude);
>> +		schedule_work_on(cpu, work);
>> +	}
>> +
>> +	for_each_online_cpu(cpu)
>> +		flush_work(&per_cpu(tasks_rude_work, cpu));
>>  }
>>  
>>  static void call_rcu_tasks_rude(struct rcu_head *rhp, rcu_callback_t
>func);
>> -- 
>> 2.53.0

--- Thanks!
"I'm not a very positive person" - Linus torvalds
