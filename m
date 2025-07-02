Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7614124111D;
	Wed,  2 Jul 2025 09:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751447686; cv=none; b=sAAfsCTB2LiWP6zvh/geVue3T95FP1RKEPd8/nkXfniDSTt9FPgWuNik0Svn/CXoivtgUZ1x0utvtq7NW/y0r1s6eSDOhAiDBmd+XdiKn+xBnSXhsKfBni91/b+t5tRYaRBuKiWGj2gKqqCoFO7G4BOSMWZFmN/SBZw9pUPDEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751447686; c=relaxed/simple;
	bh=fins2nf4nlvSpl6nY+hYPifI0DB6eGw9hwvdzJ7z/D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Wpx1nPxXBmIzLL5OhEqmpIWnfA5PoWOw9z7Dcv5kz41ceZXEDmGe8I2mPhufRon4Q/iWhhnYPn3pjX482PFeonA0v8Nc2fTvcTgOea/fp9T3KetNkDgf/KDL7oKlw66l5JEF+Ls1SQ6EOFSCQqJw45vHhKLJGFwySWahxPal1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bXDdW3NyNzvQB9;
	Wed,  2 Jul 2025 17:10:39 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 66D7B140277;
	Wed,  2 Jul 2025 17:14:40 +0800 (CST)
Received: from kwepemn200010.china.huawei.com (7.202.194.133) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 17:14:40 +0800
Received: from [10.174.178.56] (10.174.178.56) by
 kwepemn200010.china.huawei.com (7.202.194.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Jul 2025 17:14:39 +0800
Message-ID: <506d8c4e-c317-4c85-9bcf-695596551d28@huawei.com>
Date: Wed, 2 Jul 2025 17:14:38 +0800
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [QUESTION] problems report: rcu_read_unlock_special() called in
 irq_exit() causes dead loop
To: Joel Fernandes <joelagnelf@nvidia.com>, <paulmck@kernel.org>, "Xiongfeng
 Wang" <wangxiongfeng2@huawei.com>
CC: Joel Fernandes <joel@joelfernandes.org>, <ankur.a.arora@oracle.com>,
	Frederic Weisbecker <frederic@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	<neeraj.upadhyay@kernel.org>, <urezki@gmail.com>, <rcu@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Wangshaobo (bobo)"
	<bobo.shaobowang@huawei.com>, Xie XiuQi <xiexiuqi@huawei.com>
References: <9acd5f9f-6732-7701-6880-4b51190aa070@huawei.com>
 <CAEXW_YRC=f6i3KOd_uhuH=xAOCG7mW7-LwtA4+_fc8FMjfRHeg@mail.gmail.com>
 <3ce6f3ce-5dfb-8c59-cb7b-4619b70f8d25@huawei.com>
 <20250603185939.GA1109523@joelnvbox>
 <066e8121-c6c5-48ac-b35a-e6430d986dff@nvidia.com>
 <a82784fd-d51e-4ea2-9d5c-43db971a3074@nvidia.com>
 <c448118b-9f7e-4c29-d6b3-a66e70f7163f@huawei.com>
 <a963b475-72cd-474d-96d4-9e651fc8f857@paulmck-laptop>
 <e7354668-2573-4564-834b-44d76d983222@nvidia.com>
 <09e4d018-3db4-404e-a8f0-041cdee15a62@huawei.com>
 <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
Content-Language: en-GB
From: Qi Xi <xiqi2@huawei.com>
In-Reply-To: <279d2f06-d4f7-46e1-9678-999a2d19b710@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemn200010.china.huawei.com (7.202.194.133)

Hi Joel,

After applying the 2 patches, the problem still exists. Compared to the 
previous fixes which did solve the problem, the difference is 
ct_in_irq() in the first patch.

I am wondering why "nesting != CT_NESTING_IRQ_NONIDLE" is added?


(previous fix: problem is solved)

+bool ct_in_irq(void)
+{
+    return ct_nmi_nesting() != 0;
+}

(current fix: problem still exists)

+bool ct_in_irq(void)
+{
+    long nesting = ct_nmi_nesting();
+
+    return (nesting && nesting != CT_NESTING_IRQ_NONIDLE);
+}


On 2025/7/1 21:29, Joel Fernandes wrote:
>
> On 7/1/2025 5:20 AM, Qi Xi wrote:
>> Hello everyone,
>>
>> Friendly ping about this problem :)
>>
> Ah, thanks for checking. The fix is slated for kernel 6.17.
>
> If you want to test it, could you apply it in advance from the RCU tree?
>
> You need these 2:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=6758c93749f8bf09b9282f100c5dd0a5c501f91c
>
> https://git.kernel.org/pub/scm/linux/kernel/git/rcu/linux.git/commit/?h=next&id=3cd298bf3bb69e3bca6abfe97e1b44ffa37f3dee
>
> Thanks.
