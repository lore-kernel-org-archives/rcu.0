Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.75.44.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795615236;
	b=3pAbidCxENFiPC+PLzOlBP5su/YzWngovQ9gZcFwJwOIOBuE3oFZBMPVbwxB6aVG26kN
	 eOtdrrsGa3zLijQr9yNE57KMUw3TOdwwuic1pAf9Lwc+DSWRP28H0UOmDtRSGDVzv6Z3h
	 uQFObbJR7KzFJKtIGF/5ukGGDwfsStFfa2KtxQaqZxdsDqwZq0QjbeDiIawPJaDjHmhXN
	 lAQj8Se2ztSLQ+eO81A5IPHT/vO+mg22zfxgUaOgzyokcxzqYP9JJ5DL6MT+Wcf6AKslg
	 NDTX9RDAutoVse8hWsRKjsYRy0OpV02dApa5GPZUaaejGRDFNRMvhQfVhJsT15TFYuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795615236;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=r4+2+jMmv2hFcygV8FuJw7kJcgwJiGfQLbc2dz4vy00=;
	b=gpn1Bvy5KnS9FM69zKoirwoOrb3WDJai0rqhIxMcXoFCfIdvGl7FMv+Tw+Bt2o2W/8hg
	 0JRL1kUk0kxNAiezwbBjEGfVsYIOhNlOfZpEoZxAaktQFljxPWJ2lQVeSZwTSzSPHG0GB
	 nYIviOOpIhJIDwZlxmUpXZj5Matg9z8pUnjkrhErVv2WKl8dIFGVgbMnes7uX/Zu6JKIz
	 Rgx5ik+tg43W4aUvwa/ffMaD9hCw3TXcwe2ptHRAeKxgKclI9fFkx7XYxtl4MWhuX3XaT
	 rWdA2qdRoCCJJlGrCRwjp2q27USRQy1APWay+o3c7aOFpUCmox/B8WFGU6baGGoxAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=13.75.44.102
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4630B606A323;
	Wed, 25 Nov 2026 14:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4630B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.50])
	by app2 (Coremail) with UTF8SMTP id IQEQrMDmzRD@6QZrdZUDAA--.9247S2;
	Wed, 25 Nov 2026 22:00:30 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wBn8jz66QZrK9JzAA--.7663S2;
	Wed, 25 Nov 2026 22:00:27 +0800 (CST)
Message-ID: <9d2b25e4-c5a0-4ef0-8698-1a622d05223e@hust.edu.cn>
Date: Wed, 25 Nov 2026 22:00:26 +0800
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
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add RCU/whatisRCU.rst Chinese
 translation
To: Weijie Yuan <wy@wyuan.org>, Bruce Song <xiongwei.song@linux.dev>
Cc: alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, paulmck@kernel.org,
 linux-doc@vger.kernel.org, rcu@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261118131636.5131-1-xiongwei.song@linux.dev>
 <20261118131636.5131-3-xiongwei.song@linux.dev>
 <09ef3d3d-0e68-49c6-a6a2-c754104ede9e@hust.edu.cn>
 <946792d2-4241-445d-820b-301a570ee2c3@linux.dev> <awZZVV3BlovD-xNf@wyuan.org>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <awZZVV3BlovD-xNf@wyuan.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMDmzRD@6QZrdZUDAA--.9247S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoWxGF4kurWkuFW5XryDCF17Jrb_yoW5Aw4Dpa
	1rKayDtr1DJr12kr4DKw4jvFsYvrWUJF4UWryfJasxJrZFv3Z2gr4Ig3909r9Igrn3WrWj
	vay5tasFvas8u3DanT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02
	Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0pbytUUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 11/25/26 11:43 AM, Weijie Yuan wrote:
> On Tue, Nov 24, 2026 at 10:23:50PM +0800, Bruce Song wrote:
>
> [...]
>
>>>> +:翻译:
>>>> +
>>>> + 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
>>>> +
>>>> +:校译:
>>>> +
>>>> +.. _zh_cn_whatisrcu_doc:
>>>
>>> Please double check all the references. If one reference is not referred
>>> from other places, please remove it in the translation.
>> Ok, I will do that.
> Let's make it a rule or instruction, shall we?
>
> I didn't find any specific rules for label usage in doc-guide dir. (only
> no more top-level label on list) But I suspect there must be unused
> labels in English docs.
>
> We either:
>
> (1) make it consistent, i.e. keep adding unused labels.
>
> or
>
> (2) check usused labels and do not create new labels for it.
>
> 1 may be easier for manual translating jobs that you don't need to check
> every label manually. You just need to add a '_zh' before each original
> label. But apparently this will create tons of unused labels. So, no?
>
> 2 may costs more attention, but I guess agents could handle this
> nowadays with proper prompts.


I prefer this solution for some reasons:

1. If I understand correctly, Jon asked us not to add useless labels in 
the translations.

2. The labels in original English documents may be invalid, we should 
not inherit them blindly. Only if you find some place refers to this 
label, you can add it to our translation.

Dongliang Mu


>
> I forgot to mention this thing in Daniel's series [*], shall we mention
> this now, or send a RFC patch after they get merged?
If it is not merged, comment now.
>
> And also, add a rule for English docs that _do_not_ write a label which
> is not used? This will make our job easier.
>
> [*] https://lore.kernel.org/linux-doc/20261119041009.63651-1-danielmaraboo@gmail.com/
>
>
> [...]
>
>
>>>> +概括起来如下：
>>>> +
>>>> +-    使用rcu_read_lock()和rcu_read_unlock()守护RCU读端临界区。
>>>> +
>>>> +-    在一个RCU读端临界区之内, 使用rcu_dereference()解引用RCU保护的指针。
>>>> +
>>>> +-    使用可靠的设计（例如锁或信号量）保持在互相干扰的情况下并发更新。
>>>
>>> |The original says to use locks or semaphores to prevent concurrent
>>> updates from interfering with each other. Please change this to “使用可
>>> 靠的设计（例如锁或信号量）防止并发更新互相干扰”。|
>> The verb in original doc is "keep", and the objective is "updates" here.
>> IMO, "prevent" has changed the original meaning, and the objective has been
>> changed to "interfering with each other". Or do you have any other thoughts?
> In my dictionary, "keep A from doing B" means "防止 A 做 B",
> so something like:
>
> Use some solid design (such as locks or semaphores) to keep
> concurrent updates from interfering with each other.
>
> 采用可靠的同步机制（例如锁或信号量），防止并发更新相互干扰。
>
> Thanks.

