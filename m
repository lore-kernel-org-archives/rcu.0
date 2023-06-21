Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46977EB64D7
	for <rcu@archiver.kernel.org>; Wed, 21 Jun 2023 01:39:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjFUBjC (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 20 Jun 2023 21:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjFUBjB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 20 Jun 2023 21:39:01 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515291720;
        Tue, 20 Jun 2023 18:39:00 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qm5kl4Ddcz4f3p1M;
        Wed, 21 Jun 2023 09:38:55 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgA3khysVJJkCuQJLg--.44623S2;
        Wed, 21 Jun 2023 09:38:56 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v5 2/2] bpf: Call
 rcu_momentary_dyntick_idle() in task work periodically
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
References: <20230619143231.222536-1-houtao@huaweicloud.com>
 <20230619143231.222536-3-houtao@huaweicloud.com>
 <CAADnVQLPpnTT2W1Ev6Q5g2h2qk6aoFa9uFsuc7Q6Xb36e4YV3w@mail.gmail.com>
 <88a55864-d279-d004-e134-fa9a57c37bc7@huaweicloud.com>
 <CAADnVQ+xLcb3eb1xTnVdv_5MnG8UMD1hOor8-exVcqKsvfwD_A@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <866b55d8-6c85-4ee1-9590-933415d47f3f@huaweicloud.com>
Date:   Wed, 21 Jun 2023 09:38:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+xLcb3eb1xTnVdv_5MnG8UMD1hOor8-exVcqKsvfwD_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgA3khysVJJkCuQJLg--.44623S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1UZF47Gry3tF18Zw45GFg_yoW8Cr43pF
        W5KFWjkFWDJFsruryIvw4UAryDKr4fW3y2kF1DKFZ8Arn8Jr1vg3WDKa1rZ34rCr18G342
        vF4jkasavFy5Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/21/2023 9:20 AM, Alexei Starovoitov wrote:
> On Tue, Jun 20, 2023 at 6:07 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> Hi,
>>
>> On 6/21/2023 12:15 AM, Alexei Starovoitov wrote:
>>> On Mon, Jun 19, 2023 at 7:00 AM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> +static void bpf_rcu_gp_acc_work(struct callback_head *head)
>>>> +{
>>>> +       struct bpf_rcu_gp_acc_ctx *ctx = container_of(head, struct bpf_rcu_gp_acc_ctx, work);
>>>> +
>>>> +       local_irq_disable();
>>>> +       rcu_momentary_dyntick_idle();
>>>> +       local_irq_enable();
>>> We discussed this with Paul off-line and decided to go a different route.
>> "A different route" means the method used to reduce the memory footprint
>> is different or the method to do reuse-after-rcu-gp is different ?
> Pretty much everything is different.
I see.
>
>>> Paul prepared a patch for us to expose rcu_request_urgent_qs_task().
>>> I'll be sending the series later this week.
>> Do you plan to take over the reuse-after-rcu-gp patchset ?
> I took a different approach.
> It will be easier to discuss when I post patches.
> Hopefully later today or tomorrow.
Look forward to the new approach.
>
>> I did a quick test, it showed that the memory footprint is smaller and
>> the performance is similar when using rcu_request_urgent_qs_task()
>> instead of rcu_momentary_dyntick_idle().
> Right. I saw a similar effect as well.
> My understanding is that rcu_momentary_dyntick_idle() is a heavier mechanism
> and absolutely should not be used while holding rcu_read_lock().
> So calling from irq_work is not ok.
> Only kworker, as you did, is ok from safety pov.
It is not kworker and it is a task work which runs when the process
returns back to userspace.
> Still not recommended in general. Hence rcu_request_urgent_qs_task.
Thanks for the explanation.

