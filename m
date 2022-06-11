Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EBD3C433EF
	for <rcu@archiver.kernel.org>; Sat, 11 Jun 2022 16:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbiFKQdL (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 11 Jun 2022 12:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiFKQdK (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 11 Jun 2022 12:33:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A980E205
        for <rcu@vger.kernel.org>; Sat, 11 Jun 2022 09:33:07 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bo5so2078958pfb.4
        for <rcu@vger.kernel.org>; Sat, 11 Jun 2022 09:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=eYTjSteehS/9bqxvK9gzpphfN0yym4BeUslPCWcTEyc=;
        b=GZge180IIjp5LVPkgQj1ZvNfa+ch6obVOQjTApf8noS2ZgqToU6InjNszSiqK0+Sb/
         547r2lrNGxgCyTNq3OugF5oo40xQtOHp/MrhttRNuLXlMJsU2SDuY9saPKvKBc3njSoc
         H6UjisfS15gRCK1TL7lhhfmRNSGPf5NWLfGx7mOW6hzf+0sVKry4vq8je2cQmuA8f49R
         z9k0p5NWFjLFuF8Nydm7bcLuO5jSrAZjYvv8cSNsCcMET8n/TdaTolSNSZMgPbPyqOhk
         +++6jdeGH63BejWmbirWD/xy0L/IitJqOEy7tZToY30elS8pDsAcddWjgMM6SJjWqS0R
         sCNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=eYTjSteehS/9bqxvK9gzpphfN0yym4BeUslPCWcTEyc=;
        b=jbGggLcUHm+ev+9wEpRGU9EGxKkxGuerVCovgLNlpsbfF71nOxnarKTlLo7yQXHLCl
         nrpTU75QvIi8c4Y28oki+DYUnQY3U912TqG/E00M3b9oCbU8XT8jVCQHQI5B2NA152C7
         f3MqEf7zMTNWzsK2SFmmj7Y2phkNUOH1EK5v44gxQs55jQuTkRdC6PeeZBt7HgiFJfjU
         mEJ/68McYYYIGpunyM3YhTKDKuZKtaNIlTSff1vf/2QkJQmMeJN2BaebikuufRjrl//z
         n7sl1B2ir72RWPiStcBAsazp9y63D+1uhUR22ujhrdJo3Um3+jzzzOrWpPdc6Sc4IGn+
         7SXw==
X-Gm-Message-State: AOAM532u4y539VY3yK3hKuQP53Ovuq8JwgddyVjq5JfSKk9AzOsiNaUT
        //8Ywr5Zs787FU5kCfRcbT/RCg==
X-Google-Smtp-Source: ABdhPJy6IsiXDs53CaktI4Y51WPqyuGiKumgCwnb/o9IQbPpF+nN1quss8lRak3R9FSPsqVprlaDaA==
X-Received: by 2002:a63:df03:0:b0:405:f5f:345f with SMTP id u3-20020a63df03000000b004050f5f345fmr4285293pgg.195.1654965187257;
        Sat, 11 Jun 2022 09:33:07 -0700 (PDT)
Received: from [10.115.0.6] ([199.101.192.37])
        by smtp.gmail.com with ESMTPSA id x13-20020a63aa4d000000b003f66a518e48sm1850810pgo.86.2022.06.11.09.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 09:33:06 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers
 from consuming CPU) cause qemu boot slow
Message-ID: <20615615-0013-5adc-584f-2b1d5c03ebfc@linaro.org>
Date:   Sun, 12 Jun 2022 00:32:59 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi, Paul

When verifying qemu with acpi rmr feature on v5.19-rc1, the guest kernel 
stuck for several minutes.
And on 5.18, there is no such problem.

After revert this patch, the issue solved.
Commit 282d8998e997 (srcu: Prevent expedited GPs and blocking readers 
from  consuming CPU)


qemu cmd:
build/aarch64-softmmu/qemu-system-aarch64 -machine 
virt,gic-version=3,iommu=smmuv3 \
-enable-kvm -cpu host -m 1024 \
-kernel Image -initrd mini-rootfs.cpio.gz -nographic -append \
"rdinit=init console=ttyAMA0 earlycon=pl011,0x9000000 kpti=off acpi=force" \
-bios QEMU_EFI.fd

log:
InstallProtocolInterface: 5B1B31A1-9562-11D2-8E3F-00A0C969723B 7AA4D040
add-symbol-file 
/home/linaro/work/edk2/Build/ArmVirtQemu-AARCH64/DEBUG_GCC48/AARCH64/NetworkPkg/IScsiDxe/IScsiDxe/DEBUG/IScsiDxe.dll 
0x75459000
Loading driver at 0x00075458000 EntryPoint=0x00075459058 IScsiDxe.efi
InstallProtocolInterface: BC62157E-3E33-4FEC-9920-2D3B36D750DF 7AA4DE98
ProtectUefiImageCommon - 0x7AA4D040
   - 0x0000000075458000 - 0x000000000003F000
SetUefiImageMemoryAttributes - 0x0000000075458000 - 0x0000000000001000 
(0x0000000000004008)
SetUefiImageMemoryAttributes - 0x0000000075459000 - 0x000000000003B000 
(0x0000000000020008)
SetUefiImageMemoryAttributes - 0x0000000075494000 - 0x0000000000003000 
(0x0000000000004008)
InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952C8
InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
InstallProtocolInterface: 18A031AB-B443-4D1A-A5C0-0C09261E9F71 754952F8
InstallProtocolInterface: 107A772C-D5E1-11D4-9A46-0090273FC14D 75495358
InstallProtocolInterface: 6A7A5CFF-E8D9-4F70-BADA-75AB3025CE14 75495370
InstallProtocolInterface: 59324945-EC44-4C0D-B1CD-9DB139DF070C 75495348
InstallProtocolInterface: 09576E91-6D3F-11D2-8E39-00A0C969723B 754953E8
InstallProtocolInterface: 330D4706-F2A0-4E4F-A369-B66FA8D54385 7AA4D728


Not sure it is either reported or solved.

Thanks







