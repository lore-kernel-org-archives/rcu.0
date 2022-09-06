Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42289ECAAA1
	for <rcu@archiver.kernel.org>; Tue,  6 Sep 2022 22:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiIFWcF (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Sep 2022 18:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiIFWcE (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Sep 2022 18:32:04 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAFD8A7F4
        for <rcu@vger.kernel.org>; Tue,  6 Sep 2022 15:32:03 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w4so5363351qvp.2
        for <rcu@vger.kernel.org>; Tue, 06 Sep 2022 15:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Mtcu5af70evTT3fbOV+V5zfVRDwyrQCko52sY5cVhcg=;
        b=MUKUNeSzKJdsN3Qb5nS1G483fq8T2gOozXD2zdbdk3Bcl8juL7DedSlztqB/fS3WOr
         PKGORSNOiC2CbmrQpSQj1L8+HWnEJUeRPV3zyPwlUmczmpnzRciLBJhs22DxJzIo51GY
         aiy8qQEire1kRnPm1A3+Zknfdtv7QB/xD99tw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mtcu5af70evTT3fbOV+V5zfVRDwyrQCko52sY5cVhcg=;
        b=mSDB/l+DFgJSUy8GCGnqZ1s4A0vBmZ12EmLrwWuYrJfpMxdutENcph3kG6x0pEiwPi
         zWFoqJqU93mHlZsaq2W+43t+k6gt0i/FhR3MFg+ANtWkQ1J3aqAHQW0fCHABRqWsNUJj
         TDwNJfwvJG5mQOB0fouuWs/MmRUP10/tWDyGjkW2CYn3VQHBzzsPKeGplL6A4C4LIOeY
         mtfzhR616xGRFYhzE9AcqJRMu5O9GZzime2m0PYZrbxw5AqAojn07PtDVpH22j80TN32
         8DaHYHhAZnaH8OB6A0U/OJNGfhJ+fA/WE618ceBIMis+JFGl+QQ4Jho+SN2hDHZF3zi9
         EaEA==
X-Gm-Message-State: ACgBeo0I/DPj/CxtBZwISHmPxOBC2NOJBlw+9cuHa3FKUyu022rweisf
        AOO9JH1rPoEWwMQU/UNOKuXqJA==
X-Google-Smtp-Source: AA6agR6T0S3GHapOEkuvZVWSZvxnakTwXjtf6NmVBM9YBxg+CfGLtCYEnFsRahjA9ta7k6QRkN6GkQ==
X-Received: by 2002:a05:6214:20cf:b0:476:c8d:6da6 with SMTP id 15-20020a05621420cf00b004760c8d6da6mr581223qve.98.1662503522308;
        Tue, 06 Sep 2022 15:32:02 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id bi3-20020a05620a318300b006b61b2cb1d2sm11855463qkb.46.2022.09.06.15.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:32:02 -0700 (PDT)
Message-ID: <ecd0497e-5623-0bf9-0160-79dca921a0a7@joelfernandes.org>
Date:   Tue, 6 Sep 2022 18:31:59 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v5 03/18] rcu/tree: Use READ_ONCE() for lockless read of
 rnp->qsmask
Content-Language: en-US
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, frederic@kernel.org, paulmck@kernel.org,
        rostedt@goodmis.org, vineeth@bitbyteword.org
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-4-joel@joelfernandes.org>
 <YxfJGYP2l0xbxxdr@boqun-archlinux>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <YxfJGYP2l0xbxxdr@boqun-archlinux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org



On 9/6/2022 6:26 PM, Boqun Feng wrote:
> On Thu, Sep 01, 2022 at 10:17:05PM +0000, Joel Fernandes (Google) wrote:
>> The rnp->qsmask is locklessly accessed from rcutree_dying_cpu(). This
>> may help avoid load/store tearing due to concurrent access, KCSAN
> 
> Nit: you can avoid only load tearing with READ_ONCE().
> 

I modified it as you suggested for the next revision, thanks.
