Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A24C77B73
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 18:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243645AbjEZS7B (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243630AbjEZS67 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 14:58:59 -0400
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376BB13A;
        Fri, 26 May 2023 11:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1685127536;
        bh=n8UtLLL7MeH+WxjGi6mdHGUgV4zOAdY84/FWBVF10eQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EXAclzRSVyyGe4sxzeUw0gc1ic+L1C5A4r32bT+JVI5YkECYJPLa4XZQLvbgu08aU
         2QMp7vFHEtW7KDcMynH/YPycEalNlBxrUt3FKyV9Rlp49M8UIgAMJ8J2jtTHqT4QDY
         u2RogTX9vIX7qCF6taEdkcgh6hvt++Oa5V86UdXIajCV+IwBGsSMN1lwi2OAT0IJGl
         +cQS15x6sVeuG4oTD7T2fXlRX0oXBagHm1WzxgcntvfArglXd/wxLboFubhEKJ0Ak/
         gmYQAttcKBxYo1rqSxH7M+LOSwuI15zs/JIi3ULoDWCI7DMK+LF5zup6igmRPdL9V8
         T3uWAGYHakHeg==
Received: from [IPV6:2605:8d80:581:38b8:cb6e:1465:9ef2:4900] (unknown [IPv6:2605:8d80:581:38b8:cb6e:1465:9ef2:4900])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QSZ2k1x5kz1604;
        Fri, 26 May 2023 14:58:54 -0400 (EDT)
Message-ID: <e63ca3f4-283a-05fb-d637-c7428d87c8f2@efficios.com>
Date:   Fri, 26 May 2023 14:58:53 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
 <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/26/23 14:49, Waiman Long wrote:
[...]
> 
> BTW, do we have a use case for double_lock_guard/double_lock_scope? I 
> can envision a nested lock_scope inside a lock_scope, but taking 2 auto 
> locks of the same type at init time and then unlock them at exit just 
> doesn't make sense to me.

AFAIU taking both runqueue locks for source and destination runqueues on 
migration is one use-case for double_lock_guard/scope.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

