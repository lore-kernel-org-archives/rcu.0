Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3619FC433F5
	for <rcu@archiver.kernel.org>; Tue, 30 Nov 2021 11:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhK3LcE (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 30 Nov 2021 06:32:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231402AbhK3LcE (ORCPT
        <rfc822;rcu@vger.kernel.org>); Tue, 30 Nov 2021 06:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638271724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yZqFBMQmU1IhB8ncRVftJNI3p0Vlo844LTlyhHxLazk=;
        b=UYjWY9uAOXDzXKY+TcBbNXEl+AKwQ77gjcUSM8QggFjFzKzZxJJPRJvmpxP6ZUUTYLKtbf
        3MzUxIaNeOgG5PcIhIpDDrH4wNkgUSpK2/7MG59NnlM+zce67XA3k/rL86znKn1XYWCzxm
        kswGx4MC2eJSqwaKNgGVKOvVm3hWzXI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-376-3NJfoqs0ND61Tje3DQBeoQ-1; Tue, 30 Nov 2021 06:28:43 -0500
X-MC-Unique: 3NJfoqs0ND61Tje3DQBeoQ-1
Received: by mail-wm1-f71.google.com with SMTP id a85-20020a1c7f58000000b0033ddc0eacc8so11716569wmd.9
        for <rcu@vger.kernel.org>; Tue, 30 Nov 2021 03:28:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=yZqFBMQmU1IhB8ncRVftJNI3p0Vlo844LTlyhHxLazk=;
        b=yuWLoXUiWGSr7vDXWm9AQl1caJH8TPJScJLEQhYXkiI2RiJLk/mYB/shzCb4XW+mmc
         1uFqr5wphLOU+12YakHjP3aSodZcU+b4i7VP/kDJwfjv8KFfAWVD4hXTd8XBH06MVD0c
         NS5zcfHJgY/XJxUu17YKPkKKatD40aMA73Z326PGy/UusCsexxbo6rOGPw/pr/csIzON
         +tuLjlS5QMRYOa5BhYm5ldVValpFYfFJQaqQKHTAl3SlkFN82tMTgH9+59O2/wR2Gy8Q
         PMrdAmAICkyWGvoNi5N6BFWVPHeE/Vt4rYNsP+xfZOAlMiqfVArvY94mRRv7wyosTI/D
         U0bw==
X-Gm-Message-State: AOAM533a4B5AN8oIWp1d/Z/x9+KjsD8/vt8K0m+hnGzPoecHoZDvBgIu
        v+pDXy26XJC0B7/Vps5Th1/wOpSxY7Keju8Bjw+B/061ImX0hmmrilrHfD2iGp1Z9NNhZjjmUeD
        uDVE+rwGFQiys
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr4254406wmp.46.1638271722537;
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx/9GrALUeaBbvZUBckwc79sI7gw19bJw72Npbegb+eXE0pVIKTWiKgjhI8d3++hkKkU2yZJw==
X-Received: by 2002:a05:600c:4c96:: with SMTP id g22mr4254381wmp.46.1638271722371;
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae? ([2a0c:5a80:3c10:3400:3c70:6643:6e71:7eae])
        by smtp.gmail.com with ESMTPSA id k37sm2413311wms.21.2021.11.30.03.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:28:42 -0800 (PST)
Message-ID: <8719ad46cc29a2c5d7baac3c35770e5460ab8d5c.camel@redhat.com>
Subject: Question WRT early IRQ/NMI entry code
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        rcu@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, paulmck@kernel.org,
        mtosatti <mtosatti@redhat.com>, frederic <frederic@kernel.org>
Date:   Tue, 30 Nov 2021 12:28:41 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 (3.42.1-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi All,
while going over the IRQ/NMI entry code I've found a small 'inconsistency':
while in the IRQ entry path, we inform RCU of the context change *before*
incrementing the preempt counter, the opposite happens for the NMI entry
path. This applies to both arm64 and x86[1].

Actually, rcu_nmi_enter() — which is also the main RCU context switch function
for the IRQ entry path — uses the preempt counter to verify it's not in NMI
context. So it would make sense to assume all callers have the same updated
view of the preempt count, which isn't true ATM.

I'm sure there an obscure/non-obvious reason for this, right?

Thanks!
Nicolas

[1] 
IRQ path:
  -> x86_64 asm (entry_64.S)
  -> irqentry_enter() -> rcu_irq_enter() -> *rcu_nmi_enter()*
  -> run_irq_on_irqstack_cond() -> irq_exit_rcu() -> *preempt_count_add(HARDIRQ_OFFSET)*
  -> // Run IRQ...

NMI path:
  -> x86_64 asm (entry_64.S)
  -> irqentry_nmi_enter() -> __nmi_enter() -> *__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET)*
                          -> *rcu_nmi_enter()*

For arm64, see 'arch/arm64/kernel/entry-common.c'.

