Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.161.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794840555;
	b=CjNf5yi/1PHMyHx35y6G8QaievFPLKpLk2EigOWcHV9OFgvRO7eaZlyCwX+/tBITIgRR
	 UvJkyfVxPzeqqc/ovUEMb5yLhqRnhkvPgZV2KgdgXs1frNdcZTHsLFaXMDIgZm/rA+9qw
	 I4LIqHdMZegkM53BGQSRNCk7lOqJELPetNPhJm8QMZPLps3tnB2gYgHfTzgr3xlazA/pS
	 6q+9uZwaQkIJmBYrjIbtvo0QFo05bg2+LDNbH2ddRdApwFUDF9W9fA5BCOQZ7jegtTDHY
	 dkXu2Dgxftr2YI2h3aXa1qhvTjZscckYIXzZ/oUvLPMg2ZHu+AcNfu2qE1YbxgLxY/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794840555;
	h=DMARC-Filter:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=0P7IhuoEAlIgIeaASYKjjxjkw6sQN/BUUnRORtlONC0=;
	b=u50Z/8q6FVi88ib5XEuk8LNLSlD2W2ivArm+LUcMpPDxj2rAKEGpX9jRd4fUTmgofJMv
	 2mERKPUSa2x5wTGbHAXW0Tedw8KaEK2CzLSONOSwXGfeEuvE2z63AhTdsVgG/MRF+IDwm
	 IdDu+pnFoM/nVxFNcrpDtOgMbVNvhjtbbnIg1b0tKUVSnxE60GGZYQDGy7nfoBb4wRYU1
	 LWv6vScxMpoU5YAkyVD22hORifBkYvYY6zNdOjnYL2LX1CxUpj/PiUKfpWIpUeGTc7V+1
	 Ycu9BRfdlw62jomuuI59mcClBgkn4cjHEBW9FKqUZcOe8SF6My6JU5RE08oPZxg9q9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=hust.edu.cn;
	spf=pass smtp.mailfrom=hust.edu.cn;
	arc=none smtp.remote-ip=162.243.161.220
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209B606A32F;
	Mon, 16 Nov 2026 14:49:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C209B606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hust.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hust.edu.cn
Received: from hust.edu.cn (unknown [172.16.0.52])
	by app2 (Coremail) with UTF8SMTP id IQEQrMBWfcXnF_tqS2cbAA--.39072S2;
	Mon, 16 Nov 2026 22:49:11 +0800 (CST)
Received: from [100.81.40.43] (unknown [10.12.191.55])
	by gateway (Coremail) with SMTP id _____wDHz6PjF_tqn40cAA--.5619S2;
	Mon, 16 Nov 2026 22:49:08 +0800 (CST)
Message-ID: <14c51094-0bb0-4cf8-8daf-0d307d5436db@hust.edu.cn>
Date: Mon, 16 Nov 2026 22:49:07 +0800
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
Subject: Re: [PATCH 1/2] docs/zh_CN: Add RCU/index.rst translation
To: xiongwei.song@linux.dev, alexs@kernel.org, si.yanteng@linux.dev
Cc: corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
 paulmck@kernel.org, linux-doc@vger.kernel.org, rcu@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113013054.5662-1-xiongwei.song@linux.dev>
 <20261113013054.5662-2-xiongwei.song@linux.dev>
From: Dongliang Mu <dzm91@hust.edu.cn>
In-Reply-To: <20261113013054.5662-2-xiongwei.song@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:IQEQrMBWfcXnF_tqS2cbAA--.39072S2
Authentication-Results: app2; spf=neutral smtp.mail=dzm91@hust.edu.cn;
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWDAFWkZF4DCFWrury8Zrb_yoW8KFyxpr
	yDKryfKF17Jr13uw1xGFy2gry5C3Wxuw4UKr9Fq3Wvqr4DJayIyr4ayrWDKFZxGrWrAFy5
	XanY9FW09rWj937anT9S1TB71UUUUjDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQKb7Iv0xC_Zr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK
	6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1ln4kS14v26r
	126r1DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI
	12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxV
	W8Jr0_Cr1UMcIj6x8ErcxFaVAv8VW8uFyUJr1UMcIj6xkF7I0En7xvr7AKxVW8Jr0_Cr1U
	McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCY02
	Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s02
	6xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0trc3UUUUU==
X-CM-SenderInfo: asqsiiirqrkko6kx23oohg3hdfq/


On 11/13/26 9:30 AM, xiongwei.song@linux.dev wrote:
> From: Xiongwei Song <xiongwei.song@linux.dev>
>
> Translate .../RCU/index.rst into Chinese and update subsystem-apis.rst
>
> Update the translation through commit b3eb16109ae1
> ("doc: Update stallwarn.rst based on RCU Tasks Trace as SRCU")
>
> Signed-off-by: Xiongwei Song <xiongwei.song@linux.dev>
> ---
>   .../translations/zh_CN/RCU/index.rst          | 49 +++++++++++++++++++
>   .../translations/zh_CN/subsystem-apis.rst     |  1 +
>   2 files changed, 50 insertions(+)
>   create mode 100644 Documentation/translations/zh_CN/RCU/index.rst
>
> diff --git a/Documentation/translations/zh_CN/RCU/index.rst b/Documentation/translations/zh_CN/RCU/index.rst
> new file mode 100644
> index 000000000000..6db03061fd87
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/RCU/index.rst
> @@ -0,0 +1,49 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _rcu_handbook:
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/RCU/index.rst
> +
> +:翻译:
> +
> + 宋雄微 Xiongwei Song <xiongwei.song@linux.dev>
> +
> +:校译:
> +
> +============
> +RCU Handbook
> +============
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +TODOLIST:
> +
> +* checklist
> +* lockdep
> +* lockdep-splat
> +* rcubarrier
> +* rcu_dereference
> +* whatisRCU
> +* rcu
> +* rculist_nulls
> +* rcuref
> +* torture
> +* stallwarn
> +* listRCU
> +* NMI-RCU
> +* UP
> +
> +* Design/Memory-Ordering/Tree-RCU-Memory-Ordering
> +* Design/Expedited-Grace-Periods/Expedited-Grace-Periods
> +* Design/Requirements/Requirements
> +* Design/Data-Structures/Data-Structures
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   ====

Documentation/translations/zh_CN/RCU/index.rst:48: WARNING: Title 
underline too short.

Please use make htmldocs to double check your added documents has no 
compilation errors.

Dongliang Mu

> +
> +   * :ref:`genindex`
> diff --git a/Documentation/translations/zh_CN/subsystem-apis.rst b/Documentation/translations/zh_CN/subsystem-apis.rst
> index b52e1feb0167..4488a97934ec 100644
> --- a/Documentation/translations/zh_CN/subsystem-apis.rst
> +++ b/Documentation/translations/zh_CN/subsystem-apis.rst
> @@ -29,6 +29,7 @@
>      power/index
>      scheduler/index
>      locking/index
> +   RCU/index
>   
>   TODOList:
>   

