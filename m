Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C1DC433F5
	for <rcu@archiver.kernel.org>; Fri, 27 May 2022 00:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiE0A2x (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 26 May 2022 20:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiE0A2v (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 26 May 2022 20:28:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59E426A044
        for <rcu@vger.kernel.org>; Thu, 26 May 2022 17:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653611329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pg40jcleVGao/8yHsoU02qSsKOhI2WnVp+h1zYAfdd4=;
        b=Xf+O6VeU9w4OPgnezC9MTHdZzT0zIF2ddLILJxyG1VfoN6Vte0Oaq1so28V34drgrAXmt/
        tYQyeXOtmlWgTA2nYs9Zv/Sjk5ZdyHRyv3rzomRLsdFQi+1tmcGw+oAn+xhE85Fia8f9Jk
        DgvBWhTA2J+2JiO2N2Sh9moiVJCK31w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-8aORyOwBM3mouTFMHQlP8Q-1; Thu, 26 May 2022 20:28:45 -0400
X-MC-Unique: 8aORyOwBM3mouTFMHQlP8Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CA3185A5BC;
        Fri, 27 May 2022 00:28:45 +0000 (UTC)
Received: from [10.22.8.143] (unknown [10.22.8.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 33965492C3B;
        Fri, 27 May 2022 00:28:44 +0000 (UTC)
Message-ID: <9e44bb00-955a-dbc6-a863-be649e0c701f@redhat.com>
Date:   Thu, 26 May 2022 20:28:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC PATCH 4/4] cpuset: Support RCU-NOCB toggle on v2 root
 partitions
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        rcu@vger.kernel.org
References: <20220525221055.1152307-1-frederic@kernel.org>
 <20220525221055.1152307-5-frederic@kernel.org>
 <Yo/FGcG+uiBh88sT@slm.duckdns.org> <20220526225141.GA1214445@lothringen>
 <YpAHEt0j30vBw9au@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <YpAHEt0j30vBw9au@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/26/22 19:02, Tejun Heo wrote:
> On Fri, May 27, 2022 at 12:51:41AM +0200, Frederic Weisbecker wrote:
>>> Does it even make sense to make this hierarchical? What's wrong with a
>>> cpumask under sys/ or proc/?
>> I'm usually told that cpusets is the current place where CPU attributes are
>> supposed to go. I personally don't mind much /sys either even though cpusets
>> looks like a more flexible way to partition CPUs with properties and tasks
>> placement altogether...
> Yeah, I mean, if it's hierarchical, it's the right place but I have a hard
> time seeing anything hierarchical with this one. Somebody just has to know
> which cpus are up for rcu processing and which aren't. Waiman, what do you
> think?

I am thinking along the line that it will not be hierarchical. However, 
cpuset can be useful if we want to have multiple isolated partitions 
underneath the top cpuset with different isolation attributes, but no 
more sub-isolated partition with sub-attributes underneath them. IOW, we 
can only set them at the first level under top_cpuset. Will that be useful?

Cheers,
Longman

