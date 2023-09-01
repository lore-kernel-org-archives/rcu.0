Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBADACA0FEA
	for <rcu@archiver.kernel.org>; Fri,  1 Sep 2023 16:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjIAQlm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 1 Sep 2023 12:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238320AbjIAQlk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 1 Sep 2023 12:41:40 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A410EB
        for <rcu@vger.kernel.org>; Fri,  1 Sep 2023 09:41:36 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-44dbd5011beso995916137.1
        for <rcu@vger.kernel.org>; Fri, 01 Sep 2023 09:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693586496; x=1694191296; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VmUhOcfuWLkaVOCEhVcPAHsPP8uUFstrB5IczQnTPM4=;
        b=ru0A9AKoR8SqcNRycI+095xwjRpuR5WlOfI64YKwFYbU+XHC/LcPMzN37ClEoGKJt1
         hZv85Q3A1+GokEppKa1LpvU3DnIQBDBLD/qb7eAgmbg1bsgMPB7RX/gXiXEUOu9ozDIn
         1E1blHrP0BkEj7KNU6xVi7csOmAPNBSS5Rczs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693586496; x=1694191296;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VmUhOcfuWLkaVOCEhVcPAHsPP8uUFstrB5IczQnTPM4=;
        b=d3FgTBImQvWwRBIJzznSPqnfmrctlJy9UvrPgyLTQCKzvcnBu/cN/omMyf8CO9vmeK
         5Le/gvJh1KnTYUXU5uHAojVZv77d3yxY3t74/sKL0lSNuqfGaOW1RzKQfiGAIxoH8GOV
         +SRFYMvuJD4FvPCBBy8Eg9B0D81RzWMnGFwgx54TyHV4OKnxJT+UE/02cHXNhwVPgkpO
         VEJX92wlCPueS65JvGuwTqHkpwHRzksJij0QTp4SSZUIi4hS9+lBVh0PJFmMVXJArU2G
         wRT0vFtp4dN2WhZC6v6F0aKwqhL0K3Jw3BTzUg+aCFk+qWlbpMaOT9Uqc2fL23nEi+/v
         gB1g==
X-Gm-Message-State: AOJu0YxTwrr70hmU0p3s8i20TqJ9vCtz9k6dh81aTQ1zCxv7CEoySFp9
        3nNJP8At7E7K/o5WXGQWQNRU/A==
X-Google-Smtp-Source: AGHT+IE1mXepgLrLtiIO7fYm6yoVwWRhVpPWTOGAcZsgOri3Xrt0joCy91s3n/cmvixC72/fggnv4g==
X-Received: by 2002:a05:6102:3d8:b0:44d:5c61:e473 with SMTP id n24-20020a05610203d800b0044d5c61e473mr3255557vsq.22.1693586495810;
        Fri, 01 Sep 2023 09:41:35 -0700 (PDT)
Received: from smtpclient.apple ([192.145.116.44])
        by smtp.gmail.com with ESMTPSA id c6-20020ae9e206000000b00767e98535b7sm1509977qkc.67.2023.09.01.09.41.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 09:41:35 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Joel Fernandes <joel@joelfernandes.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] mm/vmalloc: Add a safer version of find_vm_area() for debug
Date:   Fri, 1 Sep 2023 12:41:24 -0400
Message-Id: <AF34FDF1-CAD9-43FD-B97D-F6A7439F310A@joelfernandes.org>
References: <ZPHdjvFwvtzXO/6z@pc636>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Zhen Lei <thunder.leizhen@huaweicloud.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Zqiang <qiang.zhang1211@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
In-Reply-To: <ZPHdjvFwvtzXO/6z@pc636>
To:     Uladzislau Rezki <urezki@gmail.com>
X-Mailer: iPhone Mail (20B101)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



> On Sep 1, 2023, at 8:48 AM, Uladzislau Rezki <urezki@gmail.com> wrote:
>=20
> =EF=BB=BFOn Fri, Sep 01, 2023 at 12:33:21AM +0000, Joel Fernandes wrote:
>>> On Fri, Sep 01, 2023 at 12:19:17AM +0000, Joel Fernandes wrote:
>>> On Thu, Aug 31, 2023 at 09:47:52PM +0200, Uladzislau Rezki wrote:
>>>> On Thu, Aug 31, 2023 at 05:18:25PM +0000, Joel Fernandes (Google) wrote=
:
>>>>> It is unsafe to dump vmalloc area information when trying to do so fro=
m
>>>>> some contexts. Add a safer trylock version of the same function to do a=

>>>>> best-effort VMA finding and use it from vmalloc_dump_obj().
>>>>>=20
>>>>> [apply test robot feedback on unused function fix.]
>>>>>=20
>>>>> Reported-by: Zhen Lei <thunder.leizhen@huaweicloud.com>
>>>>> Cc: Paul E. McKenney <paulmck@kernel.org>
>>>>> Cc: rcu@vger.kernel.org
>>>>> Cc: Zqiang <qiang.zhang1211@gmail.com>
>>>>> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>>>> ---
>>>>> v1->v2: Apply review tags and test robot feedback.
>>>>>=20
>>>>> mm/vmalloc.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>>>> 1 file changed, 38 insertions(+), 1 deletion(-)
>>>>>=20
>>>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>>>> index 93cf99aba335..f09e882ae3b8 100644
>>>>> --- a/mm/vmalloc.c
>>>>> +++ b/mm/vmalloc.c
>>>>> @@ -1865,6 +1865,20 @@ struct vmap_area *find_vmap_area(unsigned long a=
ddr)
>>>>>    return va;
>>>>> }
>>>>>=20
>>>>> +#ifdef CONFIG_PRINTK
>>>>> +static struct vmap_area *find_vmap_area_trylock(unsigned long addr)
>>>>> +{
>>>>> +    struct vmap_area *va;
>>>>> +
>>>>> +    if (!spin_trylock(&vmap_area_lock))
>>>>> +        return NULL;
>>>>> +    va =3D __find_vmap_area(addr, &vmap_area_root);
>>>>> +    spin_unlock(&vmap_area_lock);
>>>>> +
>>>>> +    return va;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> static struct vmap_area *find_unlink_vmap_area(unsigned long addr)
>>>>> {
>>>>>    struct vmap_area *va;
>>>>> @@ -2671,6 +2685,29 @@ struct vm_struct *find_vm_area(const void *addr=
)
>>>>>    return va->vm;
>>>>> }
>>>>>=20
>>>>> +/**
>>>>> + * try_to_find_vm_area - find a continuous kernel virtual area
>>>>> + * @addr:      base address
>>>>> + *
>>>>> + * This function is the same as find_vm_area() except that it is
>>>>> + * safe to call if vmap_area_lock is already held and returns NULL
>>>>> + * if it is. See comments in find_vmap_area() for other details.
>>>>> + *
>>>>> + * Return: the area descriptor on success or %NULL on failure.
>>>>> + */
>>>>> +#ifdef CONFIG_PRINTK
>>>>> +static struct vm_struct *try_to_find_vm_area(const void *addr)
>>>>> +{
>>>>> +    struct vmap_area *va;
>>>>> +
>>>>> +    va =3D find_vmap_area_trylock((unsigned long)addr);
>>>>> +    if (!va)
>>>>> +        return NULL;
>>>>> +
>>>>> +    return va->vm;
>>>>> +}
>>>>> +#endif
>>>>> +
>>>>> /**
>>>>>  * remove_vm_area - find and remove a continuous kernel virtual area
>>>>>  * @addr:        base address
>>>>> @@ -4277,7 +4314,7 @@ bool vmalloc_dump_obj(void *object)
>>>>>    struct vm_struct *vm;
>>>>>    void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
>>>>>=20
>>>>> -    vm =3D find_vm_area(objp);
>>>>> +    vm =3D try_to_find_vm_area(objp);
>>>>>    if (!vm)
>>>>>        return false;
>>>>>    pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\=
n",
>>>=20
>>> Hi Vlad,
>>> Thanks for taking a look.
>>>=20
>>>> I am not sure if this patch makes a lot of sense. I agree, this is a
>>>> problem and it mitigates it. But it is broken in terms of once you drop=

>>>> the lock, the VA should not be accessed.
>>>=20
>>> Just to note the lockless-access issue you are referring to is not intro=
duced
>>> by this patch but is rather in the existing code. Also just to note this=
 is
>>> debug code.
>>>=20
>>>> Is that a real issue or it gets triggered due to some syntetic test cas=
e?
>>>=20
>>> It is a real issue. See 2/2.
>>>=20
>>>> If i were you, i would go with open-coded version of trylock. Because
>>>> there is only one user so far.
>>>=20
>>> Taking your open coding and locking suggestions, I came up with the belo=
w
>>> which actually results in a smaller patch. Does it look good to you?
>>>=20
>>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>>> index 93cf99aba335..aaf6bad997a7 100644
>>=20
>> And with some trivial compiler errors fixed (sorry should have build test=
ed
>> but wanted to just share the idea earlier):
>>=20
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index 93cf99aba335..2c6a0e2ff404 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -4274,14 +4274,32 @@ void pcpu_free_vm_areas(struct vm_struct **vms, i=
nt nr_vms)
>> #ifdef CONFIG_PRINTK
>> bool vmalloc_dump_obj(void *object)
>> {
>> -    struct vm_struct *vm;
>>    void *objp =3D (void *)PAGE_ALIGN((unsigned long)object);
>> +    const void *caller;
>> +    struct vm_struct *vm;
>> +    struct vmap_area *va;
>> +    unsigned long addr;
>> +    unsigned int nr_pages;
>>=20
>> -    vm =3D find_vm_area(objp);
>> -    if (!vm)
>> +    if (!spin_trylock(&vmap_area_lock))
>> +        return false;
>> +    va =3D __find_vmap_area((unsigned long)objp, &vmap_area_root);
>> +    if (!va) {
>> +        spin_unlock(&vmap_area_lock);
>>        return false;
>> +    }
>> +
>> +    vm =3D va->vm;
>> +    if (!vm) {
>> +        spin_unlock(&vmap_area_lock);
>> +        return false;
>> +    }
>> +    addr =3D (unsigned long)vm->addr;
>> +    caller =3D vm->caller;
>> +    nr_pages =3D vm->nr_pages;
>> +    spin_unlock(&vmap_area_lock);
>>    pr_cont(" %u-page vmalloc region starting at %#lx allocated at %pS\n",=

>> -        vm->nr_pages, (unsigned long)vm->addr, vm->caller);
>> +        nr_pages, addr, caller);
>>    return true;
>> }
>> #endif
>>=20
> Looks good to me and thank you for fixing a locking issue :)
> I think you will re-spin and resend it one more time?

Yes. May I add your Reviewed-by tag to both patches after re-spinning as men=
tioned above?

thanks!

 - Joel

>=20
> --
> Uladzislau Rezki
