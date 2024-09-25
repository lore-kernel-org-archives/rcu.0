Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014741DCB24;
	Wed, 25 Sep 2024 12:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265794; cv=none; b=Se61/fBw3OoyAJcgLV7vZpa0YWnBBp+W32vXB9FX3QboHsydZqFbrRo3lpUehfcTNpqlxAMkeRF39QQH8sOGWAElDuQZxNkaAVclWXCgSkEA1N8T+UCcooo+Hsp1NKd6l2G3DFh0jNv1rYERvG8l44nKn+VwKRmOUZooM3QgaGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265794; c=relaxed/simple;
	bh=1kaYRJyiAfAl7JXGJzyXeta5OCaKkLICDp1w+ZIW4mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JhZVh9cuzRIWnqM89VXlNJ1WDWq2IQsrlWjwEE42TIDD69ZlEYJIK8/ufMHHowD8GVqxYJyoyGttmvPM+XT43QvUBKdUOxMHnByqZx+W8pc5Hudi/Tw4D7jxxa5Pn+oa5LTbkMrv0VWQ3BhJ80fcndJa8wyeZfos6L9eVUTnH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4XDFGt2RyFz9v7Nd;
	Wed, 25 Sep 2024 19:43:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 6A2F21402E1;
	Wed, 25 Sep 2024 20:03:02 +0800 (CST)
Received: from [10.81.208.14] (unknown [10.81.208.14])
	by APP1 (Coremail) with SMTP id LxC2BwDHWDDn+_Nmp9abAQ--.40229S2;
	Wed, 25 Sep 2024 13:03:01 +0100 (CET)
Message-ID: <b3b9e8e8-a3b5-4398-92b9-ff46b8ec53a9@huaweicloud.com>
Date: Wed, 25 Sep 2024 14:02:44 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] hpref: Hazard Pointers with Reference Counter
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Alan Stern
 <stern@rowland.harvard.edu>, John Stultz <jstultz@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Lai Jiangshan
 <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, maged.michael@gmail.com,
 Mateusz Guzik <mjguzik@gmail.com>, rcu@vger.kernel.org, linux-mm@kvack.org,
 lkmm@lists.linux.dev
References: <20240921164210.256278-1-mathieu.desnoyers@efficios.com>
 <e4721439-8cad-4134-8c07-84b6ecc69573@huaweicloud.com>
 <48ae741e-98aa-49d9-b677-6c4f8fd1bcb0@efficios.com>
 <07c9285f-44a1-486a-8390-0c63cefae35a@huaweicloud.com>
 <38b04b86-1e85-40f0-8174-3c8ab29cbcaf@efficios.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <38b04b86-1e85-40f0-8174-3c8ab29cbcaf@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDHWDDn+_Nmp9abAQ--.40229S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4xJFW8ArykWw4xZFyDAwb_yoW8Kr1Upr
	ZxKa4q9F4kGF4Fkr1xtw1UWFy0yF1ftFW5XFyvgr1fAa90gry0gr13tF98u3ZxA397JryU
	tr4FqrZxZasxJa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWr
	XwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jxCztUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/



Am 9/25/2024 um 1:36 PM schrieb Mathieu Desnoyers:
> On 2024-09-25 12:06, Jonas Oberhauser wrote:
>>
>>
>> Am 9/25/2024 um 8:35 AM schrieb Mathieu Desnoyers:
>>> On 2024-09-25 07:57, Jonas Oberhauser wrote:
>>>> Hi Mathieu,
>>
>>>> I haven't read your code in detail but it seems to me you have an 
>>>> ABA bug: as I explained elsewhere, you could read the same pointer 
>>>> after ABA but you don't synchronize with the newer store that gave 
>>>> you node2, leaving you to speculatively read stale values through 
>>>> *ctx->hp.
>>>> (I am assuming here that ctx->hp is essentially an out parameter 
>>>> used to let the caller know which node got protected).
>>>
>>> The following change should fix it:
>>>
>>>       cmm_barrier();
>>> -    node2 = uatomic_load(node_p, CMM_RELAXED);    /* Load A */
>>> +    node2 = rcu_dereference(*node_p);    /* Load A */
>>>
>>
>> I don't think this fixes it, because IIRC rcu_dereference relies on 
>> the address dependency (which we don't have here) to provide ordering.
>>
>> I would recommend either:
>>
>> -    ctx->hp = node;
>> +    ctx->hp = node2;
>>
>> which fixes the problem under the perhaps too weak assumption that the 
>> compiler doesn't use its knowledge that node==node2 to just undo this 
>> fix, or more strictly,
> 
> As stated in Documentation/RCU/rcu_dereference.rst from the Linux
> kernel, comparing the result of rcu_dereference against another
> non-NULL pointer is discouraged, as you rightly point out.
> 
>>
>> +    ctx->hp = READ_ONCE(node2);
>>
>> which I believe makes sure that the value of node2 is used.
> 
> I am not entirely sure this extra READ_ONCE() would be sufficient
> to prevent the compiler from making assumptions about the content
> of node2 and thus use the result of the first load (node) instead.
> It would also not suffice to prevent the CPU from speculatively
> using the result of the first load to perform dependent loads AFAIU.

The reason I think it should be sufficient is that it forces the 
compiler to assume that since the comparison, the value of node2 might 
have changed.
Therefore, simply using the value of node at that point should be 
unsound from the compiler's POV.

But I'm not a compiler expert... So I definitely support uneasiness 
about this construct :))

jonas

