Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140E17BD3
	for <rcu@vger.kernel.org>; Sat, 30 Nov 2024 22:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733005381; cv=none; b=diqMn09ss/W+8C/88gc0rMk4Pz0KGz5+rQLPcOTEDKj8gdgsKJWM3Esp5YP1VCfE872TcM8nWHiQF7P9CdQ+Zjvr4d4Z6nfWxTrX4hnoVw+4TGeTg7yka/uFxQAJeqi3OPT9AKcGcyHzLMcFYShL39UdpGwprRUdHw2nLjY05Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733005381; c=relaxed/simple;
	bh=0IvvcDUDY8TJbK4KimI6JhkxQh8QP+EzoZ9T/flyLaY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=nIbqblLMvXAiYW8OhbaDrFXAHssWSq5CN8Dn6ZGyyzdp9mn7DOM8j8n+dQIDKDEtcdjVd+lQ4IwbQgWRmjh1ymdep4VTLVF/5aWxOLLqBRNnd7Ef1O1gLEZ7YlqvPr46+VezoXJAD23Nce6TMdq4OV/1XK/YG4Eey7J4Zu74qtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsY5Zk4e; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsY5Zk4e"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aa52edbcb63so706406466b.1
        for <rcu@vger.kernel.org>; Sat, 30 Nov 2024 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733005377; x=1733610177; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xLKP146zo0xxtQwNFZbDeNInT0znVxv5b+lZE7DK2kI=;
        b=MsY5Zk4eG8+oj1hoE1uBpZ4GmwnpR+I1WMZc4075Z5TGQwhLzJsnJ1MSYhplGW6n3K
         wPN3w670+tZaEHlQ2u1Qw1eWimkJiobO7f9ZhyC0Jjxb76jTqve6jsUSsiBqtul5Ckdp
         nsGSjjfwSwYXdOPTXi48rNW323sr0gsrz2TM7GCmBF2QBdPGjfPaZo42Ab5grQTXCCIi
         D/MOXf0ChFaIP4WtcbM995TXvEeqOiw73BsV2p9uTpxyjjXGmVnKmUci22gg7nlKGi5E
         mj5Nr+gIVQ6utzUIwCF4poFJk4+F3ovXcBRQf4TEueBNXc0Gb2zKt0SfoA3qMZuzJ2cX
         /opQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733005377; x=1733610177;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xLKP146zo0xxtQwNFZbDeNInT0znVxv5b+lZE7DK2kI=;
        b=aDDAF8IfHsHCLng4cILZy5JfIEh8eLelC0+YX4LsIiqKvZWRt+ND77thQklbrkuE5a
         ye+k8Pe8bzPFE6pwzl25DNhXZiip4uaqIsajfjscLabNOiGqNehdCDZMqTKilDeXtV9S
         6qP9MKpbhDYQVF6UmCFwQIVJX3JyQSVYqGNhH73Ud8hOZ68hTArRC5UtVzGbAQyOAJwy
         i+4pkkoeeSD6aJBKW2vQGPBQD+BJP/M/tLg4nLI1XkV339g0QFior8aM6IVMh4l4/8PA
         QhHpoM3mmWtiij2VVoy680KSR6/9pv2oMvSua1Cdk/8HS6TbQv/GqN6TM6ogtyAtgIHq
         OspA==
X-Gm-Message-State: AOJu0YwyeGB9EZmLaBmo/EhaSF2bQ8LCHy+lLLkOwQoPz07K1lZvpzPl
	D4FTTKbAYCydy32ujjz2oLnqdGyZWCX2p87KQquqWuAPdIMbQP1LKzsJB0SThddU1ttGtrnYfY3
	JvrQr5XILbeiEN/hUSdxsv9WKGu1JkWlC
X-Gm-Gg: ASbGncuPwgvdF8ad3tyTQx0ACd7RWSaemr0YvgdD/PV8Txc7oQryK4jPSIqv1oDk+Gg
	yFbMv6qK2TiXRTBSDuDJhdMGIPTIniJPZ
X-Google-Smtp-Source: AGHT+IEwAMaENbcnfwYvSVK7k3NDAGXGzAT7AAkoSoVHXEdoTthsJsClkIL6K4ijaWNomYdrV74DnJR8rr8B7+UggsY=
X-Received: by 2002:a17:907:7615:b0:aa5:358c:73af with SMTP id
 a640c23a62f3a-aa5945075fdmr1544711466b.6.1733005376993; Sat, 30 Nov 2024
 14:22:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 30 Nov 2024 23:22:45 +0100
Message-ID: <CA+=Fv5R9NG+1SHU9QV9hjmavycHKpnNyerQ=Ei90G98ukRcRJA@mail.gmail.com>
Subject: Kernel Oops on alpha with kernel version >=6.9.x
To: rcu@vger.kernel.org, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,


First some background:
I've been trying to boot recent kernels on my alpha machines. Anything
after linux-6.8.12 gives me trouble. After doing a kernel bisect, I
found that commit 9187210eee7d87eea37b45ea93454a88681894a4
(net-next-6.9) is where my troubles begin. The problem consists in
that the boot process gets stuck when trying to set parameters for
network interfaces. The bad commit does make a lot of updates to the
network code.

When booting the system with kernel 6.12.0 I'm able to boot into
single-user mode, but when starting system services one by one I
trigger a kernel Oops when the network interface is renamed (see stack
dump below). Looking at the changes made by the bad commit, it seems
to (among other things) be replacing the locking mechanism (RCU
instead of rtnl_lock). The stack dump from the kernel Oops suggests
that something is happening in the RCU locking code. I'm no expert on
RCU-stuff but I read somewhere that it is done by volatile access on
all systems other than DEC Alpha, where a memory barrier instruction
is required. This indicates that the change could affect Alpha
architecture differently? Inspecting the changes to networking code in
the bad commit, particularly the changes made to net/core/dev.c, I put
together the patch below. This patch reverts one of the lines changed
in the "bad commit" for net/core/dev.c. After reverting the change on
just this line, I'm able to boot kernel 6.12.0 on my Alpha ES-40 to
full multi-user again. I've tested this on an Alpha ES40 and an
UP2000+ and the problem is 100% reproducible on both machines.

The patch might not be a real solution to the problem but could be a good
place to start looking when figuring out what's really going on. The feedback
I've gotten so far (forums and the netdev mailing list) is that the
RCU implementation on alpha is probably where things go wrong.



------------------------------------
Patch to "fix" the problem:
-----------------------------------

diff --git a/net/core/dev.c b/net/core/dev.c
index 13d00fc10f55..26fda14367e5 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1261,7 +1261,7 @@ int dev_change_name(struct net_device *dev,
const char *newname)

        netdev_name_node_del(dev->name_node);

-       synchronize_net();
+       synchronize_rcu();

        netdev_name_node_add(net, dev->name_node);


--------------------------
dmesg/kernel log:
-------------------------

[   93.431592] tulip 0000:01:02.0 enp1s2: renamed from eth0

[   93.436475] Unable to handle kernel paging request at virtual
address 0000000000000000
[   93.436475] CPU 1
[   93.436475] rcu_exp_gp_kthr(17): Oops -1
[   93.436475] pc = [<0000000000000000>]  ra = [<0000000000000000>]
ps = 0000    Not tainted
[   93.436475] pc is at 0x0
[   93.436475] ra is at 0x0
[   93.436475] v0 = 0000000000000007  t0 = fffffc0000e62440  t1 =
0000000000000001
[   93.436475] t2 = 0000000000000000  t3 = 0000000000000001  t4 =
0000000000000001
[   93.436475] t5 = 0000000000000001  t6 = 0000000000000001  t7 =
fffffc0003138000
[   93.436475] s0 = fffffc0000e62440  s1 = fffffc0000ec3a10  s2 =
fffffc0000ec3a10
[   93.436475] s3 = fffffc0000ec3a10  s4 = fffffc00003a90f0  s5 =
fffffc0000e62440
[   93.436475] s6 = 0000000000000000
[   93.436475] a0 = 0000000000000000  a1 = 0000000000000000  a2 =
0000000000000000
[   93.436475] a3 = 0000000000000000  a4 = 0000000000000001  a5 =
fffffc0000517744
[   93.436475] t8 = 0000000000000001  t9 = 0000000000000001  t10=
fffffc0000e3d320
[   93.436475] t11= fffffc0000220240  pv = fffffc0000b73210  at =
0000000000000000
[   93.436475] gp = fffffc0000eb3a10  sp = 00000000ea2ea184
[   93.436475] Disabling lock debugging due to kernel taint
[   93.436475] Trace:
[   93.436475] [<fffffc00003aee60>] wait_rcu_exp_gp+0x30/0xa0
[   93.436475] [<fffffc0000b6c200>] __cond_resched+0x30/0x90
[   93.436475] [<fffffc00003569b8>] kthread_worker_fn+0xc8/0x1f0
[   93.436475] [<fffffc000035863c>] kthread+0x17c/0x1c0
[   93.436475] [<fffffc00003568f0>] kthread_worker_fn+0x0/0x1f0
[   93.436475] [<fffffc0000311128>] ret_from_kernel_thread+0x18/0x20

[   93.436475] Code:
[   93.436475]  00000000
[   93.436475]  00000000
[   93.436475]  00063301
[   93.436475]  0000077c
[   93.436475]  00001111
[   93.436475]  000022a2
